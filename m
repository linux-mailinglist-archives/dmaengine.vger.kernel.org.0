Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D386A50AAC
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2019 14:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfFXM2U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jun 2019 08:28:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbfFXM2U (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 24 Jun 2019 08:28:20 -0400
Received: from localhost (unknown [106.201.35.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CB30205C9;
        Mon, 24 Jun 2019 12:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561379299;
        bh=xAWHMRPfHHeuUDsb2NoJwA0gB6ClzmGYlj5zwWg9ygE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MlyM/+HoLj6dP1Gga8KhvuWJr/2JNCuTOzkpKzyQtMA9G2d2AL8LpAJPPzcYZtoJc
         hoj7Vz6tmY8M6T6+WZRAuUcaEMtLhJgGUvCm3VwdSZfbP3Gsquq18W03zaSDnpgsgp
         GAwwNq3q7d2zEWW4aEsL3irBZy4q4bOA5TGRs1xU=
Date:   Mon, 24 Jun 2019 17:55:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     dan.j.williams@intel.com, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [V4 1/2] dmaengine: fsl-dpaa2-qdma: Add the DPDMAI(Data Path DMA
 Interface) support
Message-ID: <20190624122509.GC2962@vkoul-mobl>
References: <20190613101341.21169-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613101341.21169-1-peng.ma@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-06-19, 10:13, Peng Ma wrote:
> The MC(Management Complex) exports the DPDMAI(Data Path DMA Interface)
> object as an interface to operate the DPAA2(Data Path Acceleration
> Architecture 2) qDMA Engine. The DPDMAI enables sending frame-based
> requests to qDMA and receiving back confirmation response on transaction
> completion, utilizing the DPAA2 QBMan(Queue Manager and Buffer Manager
> hardware) infrastructure. DPDMAI object provides up to two priorities for
> processing qDMA requests.
> The following list summarizes the DPDMAI main features and capabilities:
> 	1. Supports up to two scheduling priorities for processing
> 	service requests.
> 	- Each DPDMAI transmit queue is mapped to one of two service
> 	priorities, allowing further prioritization in hardware between
> 	requests from different DPDMAI objects.
> 	2. Supports up to two receive queues for incoming transaction
> 	completion confirmations.
> 	- Each DPDMAI receive queue is mapped to one of two receive
> 	priorities, allowing further prioritization between other
> 	interfaces when associating the DPDMAI receive queues to DPIO
> 	or DPCON(Data Path Concentrator) objects.
> 	3. Supports different scheduling options for processing received
> 	packets:
> 	- Queues can be configured either in 'parked' mode (default),
> 	oattached to a DPIO object, or attached to DPCON object.
        ^^^^^^^^^
typo?

> +struct dpdmai_cmd_open {
> +	__le32 dpdmai_id;
> +};

Do you really need a struct to handle a 32bit value?

And seeing it used once, we can skip and avoid needless cast in usage as
well!

> +/* cmd, param, offset, width, type, arg_name */
> +#define DPDMAI_CMD_CREATE(_cmd, _cfg) \
> +do { \
> +	typeof(_cmd) (cmd) = (_cmd); \
> +	typeof(_cfg) (cfg) = (_cfg); \
> +	MC_CMD_OP(cmd, 0, 8,  8,  u8,  (cfg)->priorities[0]);\
> +	MC_CMD_OP(cmd, 0, 16, 8,  u8,  (cfg)->priorities[1]);\
> +} while (0)
> +
> +static inline u64 mc_enc(int lsoffset, int width, u64 val)
> +{
> +	return (u64)(((u64)val & MAKE_UMASK64(width)) << lsoffset);

this looks not so nice. val is u64 so why is it required to cast to u64
again?

> +}
> +
> +static inline u64 mc_dec(u64 val, int lsoffset, int width)
> +{
> +	return (u64)((val >> lsoffset) & MAKE_UMASK64(width));

do we need the cast here?

> +int dpdmai_create(struct fsl_mc_io *mc_io, u32 cmd_flags,
> +		  const struct dpdmai_cfg *cfg, u16 *token)
> +{
> +	struct fsl_mc_command cmd = { 0 };
> +	int err;
> +
> +	/* prepare command */
> +	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_CREATE,
> +					  cmd_flags,
> +					  0);

This seems to fit in a single line!

> +	DPDMAI_CMD_CREATE(cmd, cfg);
> +
> +	/* send command to mc*/
> +	err = mc_send_command(mc_io, &cmd);
> +	if (err)
> +		return err;
> +
> +	/* retrieve response parameters */
> +	*token = MC_CMD_HDR_READ_TOKEN(cmd.header);

This looks very similar to dpdmai_open() and I suppose you can create a
macro to create and send cmd with optional params!

> +
> +	return 0;
> +}
> +
> +int dpdmai_enable(struct fsl_mc_io *mc_io, u32 cmd_flags,
> +		  u16 token)
> +{
> +	struct fsl_mc_command cmd = { 0 };
> +
> +	/* prepare command */
> +	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_ENABLE,
> +					  cmd_flags,
> +					  token);

This can fit in two lines

> +
> +	/* send command to mc*/
> +	return mc_send_command(mc_io, &cmd);
> +}
> +
> +int dpdmai_disable(struct fsl_mc_io *mc_io, u32 cmd_flags,
> +		   u16 token)

why two lines for this!

> +{
> +	struct fsl_mc_command cmd = { 0 };
> +
> +	/* prepare command */
> +	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_DISABLE,
> +					  cmd_flags,
> +					  token);

This also!

Please check rest of the driver for these style issues and see bunch of
places can fit into a line or two!

> +/**
> + * dpdmai_open() - Open a control session for the specified object
> + * @mc_io:	Pointer to MC portal's I/O object
> + * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
> + * @dpdmai_id:	DPDMAI unique ID
> + * @token:	Returned token; use in subsequent API calls
> + *
> + * This function can be used to open a control session for an
> + * already created object; an object may have been declared in
> + * the DPL or by calling the dpdmai_create() function.
> + * This function returns a unique authentication token,
> + * associated with the specific object ID and the specific MC
> + * portal; this token must be used in all subsequent commands for
> + * this specific object.

This is good but can you move them to C file with the function

-- 
~Vinod
