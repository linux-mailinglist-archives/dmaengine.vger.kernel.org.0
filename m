Return-Path: <dmaengine+bounces-1761-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C80D89B0BB
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 14:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8811F214C3
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 12:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948DD22324;
	Sun,  7 Apr 2024 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTjpVKpu"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6478F22075;
	Sun,  7 Apr 2024 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712492558; cv=none; b=I80YIS9uiwdtXjZebuH31/qnS3a7N35Lp+nh0rxLuSaQgaZkR15ANpfBBZ6ExHwANCGvXU3ouNEPD4zPwCKDBTT5VK2VEma6EpQ2wO1iYweeRVj/wWlQq9hwykVXmOlIG07/V5GB4xOOwkjYSz6LBV6sZUaCn67zKabT8UgFRvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712492558; c=relaxed/simple;
	bh=8Xw0AGyl1GOfO56/UoE8rVpgRMawT9/2wW8YndZPGQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4d/IB/Ueo/Bc3FThxWmIA+yBrjIa8ZvwRL0wwcK+lcxZBtzrFcktrOKYTWvxu5pRYF+8xC/tM6D9wYe4mcqXMJ8u2noMYNWeXn2zZTy+XwN+nSow01sGuNiN00w1FuUnIYQqE1cq+aj6Cges/b3tpBRsdxSujrm4cFsRrfmxxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTjpVKpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B775C433F1;
	Sun,  7 Apr 2024 12:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712492557;
	bh=8Xw0AGyl1GOfO56/UoE8rVpgRMawT9/2wW8YndZPGQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cTjpVKpuCERRKBkcYzZBXb8TVedlO74p79AenJsfQ8qsWPanFI7Pb02iTs9L7ziq1
	 62iq5l9vcZR8FABDPhR/+urKov7LAQgr9wT5UGmZWN0bG7u4NDq0khzLPPXHtLd4+8
	 WrzdLRT5Opy2KsjR1ZyqR9i0lKM2HBcCKXEJi4UzT1Gk9U2kYRK96KzWJUdeTgPv9K
	 vREYFeKfkKlf3rDfmTnpOpe9GsNzYNDiLD95942G9VZhrlhL3CwZCMR/Zee/XTuWnz
	 l+5wp7waFkobLsHTRrjjXFoVb2GupL+3Wse5kL1eKJBJ0iqJQMDJN+LRdv5cNPdwdh
	 MoH5NrWi+LmZg==
Date: Sun, 7 Apr 2024 17:52:33 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 4/4] dmaengine: fsl-dpaa2-qdma: Update DPDMAI interfaces
 to version 3
Message-ID: <ZhKQCego3QV_fkeW@matsya>
References: <20240320-dpaa2-v1-0-eb56e47c94ec@nxp.com>
 <20240320-dpaa2-v1-4-eb56e47c94ec@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320-dpaa2-v1-4-eb56e47c94ec@nxp.com>

On 20-03-24, 15:39, Frank Li wrote:
> Update the DPDMAI interfaces to support MC firmware up to 10.1x.x.

and what are these changes? Pls add them to log here...

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c | 14 ++++-----
>  drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h |  5 ++--
>  drivers/dma/fsl-dpaa2-qdma/dpdmai.c     | 53 ++++++++++++++++++++++++---------
>  drivers/dma/fsl-dpaa2-qdma/dpdmai.h     | 35 ++++++++++++++--------
>  4 files changed, 72 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> index 5a8061a307cda..36384d0192636 100644
> --- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> +++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> @@ -362,7 +362,7 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
>  
>  	for (i = 0; i < priv->num_pairs; i++) {
>  		err = dpdmai_get_rx_queue(priv->mc_io, 0, ls_dev->mc_handle,
> -					  i, &priv->rx_queue_attr[i]);
> +					  i, 0, &priv->rx_queue_attr[i]);
>  		if (err) {
>  			dev_err(dev, "dpdmai_get_rx_queue() failed\n");
>  			goto exit;
> @@ -370,13 +370,13 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
>  		ppriv->rsp_fqid = priv->rx_queue_attr[i].fqid;
>  
>  		err = dpdmai_get_tx_queue(priv->mc_io, 0, ls_dev->mc_handle,
> -					  i, &priv->tx_fqid[i]);
> +					  i, 0, &priv->tx_queue_attr[i]);
>  		if (err) {
>  			dev_err(dev, "dpdmai_get_tx_queue() failed\n");
>  			goto exit;
>  		}
> -		ppriv->req_fqid = priv->tx_fqid[i];
> -		ppriv->prio = i;
> +		ppriv->req_fqid = priv->tx_queue_attr[i].fqid;
> +		ppriv->prio = DPAA2_QDMA_DEFAULT_PRIORITY;
>  		ppriv->priv = priv;
>  		ppriv++;
>  	}
> @@ -542,7 +542,7 @@ static int __cold dpaa2_dpdmai_bind(struct dpaa2_qdma_priv *priv)
>  		rx_queue_cfg.dest_cfg.dest_id = ppriv->nctx.dpio_id;
>  		rx_queue_cfg.dest_cfg.priority = ppriv->prio;
>  		err = dpdmai_set_rx_queue(priv->mc_io, 0, ls_dev->mc_handle,
> -					  rx_queue_cfg.dest_cfg.priority,
> +					  rx_queue_cfg.dest_cfg.priority, 0,
>  					  &rx_queue_cfg);
>  		if (err) {
>  			dev_err(dev, "dpdmai_set_rx_queue() failed\n");
> @@ -642,7 +642,7 @@ static int dpaa2_dpdmai_init_channels(struct dpaa2_qdma_engine *dpaa2_qdma)
>  	for (i = 0; i < dpaa2_qdma->n_chans; i++) {
>  		dpaa2_chan = &dpaa2_qdma->chans[i];
>  		dpaa2_chan->qdma = dpaa2_qdma;
> -		dpaa2_chan->fqid = priv->tx_fqid[i % num];
> +		dpaa2_chan->fqid = priv->tx_queue_attr[i % num].fqid;
>  		dpaa2_chan->vchan.desc_free = dpaa2_qdma_free_desc;
>  		vchan_init(&dpaa2_chan->vchan, &dpaa2_qdma->dma_dev);
>  		spin_lock_init(&dpaa2_chan->queue_lock);
> @@ -802,7 +802,7 @@ static void dpaa2_qdma_shutdown(struct fsl_mc_device *ls_dev)
>  	dpdmai_disable(priv->mc_io, 0, ls_dev->mc_handle);
>  	dpaa2_dpdmai_dpio_unbind(priv);
>  	dpdmai_close(priv->mc_io, 0, ls_dev->mc_handle);
> -	dpdmai_destroy(priv->mc_io, 0, ls_dev->mc_handle);
> +	dpdmai_destroy(priv->mc_io, 0, priv->dpqdma_id, ls_dev->mc_handle);
>  }
>  
>  static const struct fsl_mc_device_id dpaa2_qdma_id_table[] = {
> diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
> index 03e2f4e0baca8..2c80077cb7c0a 100644
> --- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
> +++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
> @@ -6,6 +6,7 @@
>  
>  #define DPAA2_QDMA_STORE_SIZE 16
>  #define NUM_CH 8
> +#define DPAA2_QDMA_DEFAULT_PRIORITY 0
>  
>  struct dpaa2_qdma_sd_d {
>  	u32 rsv:32;
> @@ -122,8 +123,8 @@ struct dpaa2_qdma_priv {
>  	struct dpaa2_qdma_engine	*dpaa2_qdma;
>  	struct dpaa2_qdma_priv_per_prio	*ppriv;
>  
> -	struct dpdmai_rx_queue_attr rx_queue_attr[DPDMAI_PRIO_NUM];
> -	u32 tx_fqid[DPDMAI_PRIO_NUM];
> +	struct dpdmai_rx_queue_attr rx_queue_attr[DPDMAI_MAX_QUEUE_NUM];
> +	struct dpdmai_tx_queue_attr tx_queue_attr[DPDMAI_MAX_QUEUE_NUM];
>  };
>  
>  struct dpaa2_qdma_priv_per_prio {
> diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
> index 610f6231835a8..7fbe925831b8b 100644
> --- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
> +++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
> @@ -1,42 +1,58 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright 2019 NXP
>  
> +#include <linux/bitfield.h>
>  #include <linux/module.h>
>  #include <linux/types.h>
>  #include <linux/io.h>
>  #include <linux/fsl/mc.h>
>  #include "dpdmai.h"
>  
> +#define DEST_TYPE_MASK 0xF
> +
>  struct dpdmai_rsp_get_attributes {
>  	__le32 id;
>  	u8 num_of_priorities;
> -	u8 pad0[3];
> +	u8 num_of_queues;
> +	u8 pad0[2];
>  	__le16 major;
>  	__le16 minor;
>  };
>  
>  struct dpdmai_cmd_queue {
>  	__le32 dest_id;
> -	u8 priority;
> -	u8 queue;
> +	u8 dest_priority;
> +	union {
> +		u8 queue;
> +		u8 pri;
> +	};
>  	u8 dest_type;
> -	u8 pad;
> +	u8 queue_idx;
>  	__le64 user_ctx;
>  	union {
>  		__le32 options;
>  		__le32 fqid;
>  	};
> -};
> +} __packed;
>  
>  struct dpdmai_rsp_get_tx_queue {
>  	__le64 pad;
>  	__le32 fqid;
>  };
>  
> +struct dpdmai_rsp_is_enabled {
> +	/* only the LSB bit */
> +	u8 en;
> +} __packed;
> +
>  struct dpdmai_cmd_open {
>  	__le32 dpdmai_id;
>  } __packed;
>  
> +struct dpdmai_cmd_destroy {
> +	__le32 dpdmai_id;
> +} __packed;
> +
>  static inline u64 mc_enc(int lsoffset, int width, u64 val)
>  {
>  	return (val & MAKE_UMASK64(width)) << lsoffset;
> @@ -113,18 +129,23 @@ EXPORT_SYMBOL_GPL(dpdmai_close);
>   * dpdmai_destroy() - Destroy the DPDMAI object and release all its resources.
>   * @mc_io:      Pointer to MC portal's I/O object
>   * @cmd_flags:  Command flags; one or more of 'MC_CMD_FLAG_'
> + * @dpdmai_id:	The object id; it must be a valid id within the container that created this object;
>   * @token:      Token of DPDMAI object
>   *
>   * Return:      '0' on Success; error code otherwise.
>   */
> -int dpdmai_destroy(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
> +int dpdmai_destroy(struct fsl_mc_io *mc_io, u32 cmd_flags, u32 dpdmai_id, u16 token)
>  {
> +	struct dpdmai_cmd_destroy *cmd_params;
>  	struct fsl_mc_command cmd = { 0 };
>  
>  	/* prepare command */
>  	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_DESTROY,
>  					  cmd_flags, token);
>  
> +	cmd_params = (struct dpdmai_cmd_destroy *)&cmd.params;
> +	cmd_params->dpdmai_id = cpu_to_le32(dpdmai_id);
> +
>  	/* send command to mc*/
>  	return mc_send_command(mc_io, &cmd);
>  }
> @@ -224,6 +245,7 @@ int dpdmai_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags,
>  	attr->version.major = le16_to_cpu(rsp_params->major);
>  	attr->version.minor = le16_to_cpu(rsp_params->minor);
>  	attr->num_of_priorities = rsp_params->num_of_priorities;
> +	attr->num_of_queues = rsp_params->num_of_queues;
>  
>  	return 0;
>  }
> @@ -240,7 +262,7 @@ EXPORT_SYMBOL_GPL(dpdmai_get_attributes);
>   *
>   * Return:	'0' on Success; Error code otherwise.
>   */
> -int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
> +int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u8 queue_idx,
>  			u8 priority, const struct dpdmai_rx_queue_cfg *cfg)
>  {
>  	struct dpdmai_cmd_queue *cmd_params;
> @@ -252,11 +274,12 @@ int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
>  
>  	cmd_params = (struct dpdmai_cmd_queue *)cmd.params;
>  	cmd_params->dest_id = cpu_to_le32(cfg->dest_cfg.dest_id);
> -	cmd_params->priority = cfg->dest_cfg.priority;
> -	cmd_params->queue = priority;
> +	cmd_params->dest_priority = cfg->dest_cfg.priority;
> +	cmd_params->pri = priority;
>  	cmd_params->dest_type = cfg->dest_cfg.dest_type;
>  	cmd_params->user_ctx = cpu_to_le64(cfg->user_ctx);
>  	cmd_params->options = cpu_to_le32(cfg->options);
> +	cmd_params->queue_idx = queue_idx;
>  
>  	/* send command to mc*/
>  	return mc_send_command(mc_io, &cmd);
> @@ -274,7 +297,7 @@ EXPORT_SYMBOL_GPL(dpdmai_set_rx_queue);
>   *
>   * Return:	'0' on Success; Error code otherwise.
>   */
> -int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
> +int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u8 queue_idx,
>  			u8 priority, struct dpdmai_rx_queue_attr *attr)
>  {
>  	struct dpdmai_cmd_queue *cmd_params;
> @@ -287,6 +310,7 @@ int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
>  
>  	cmd_params = (struct dpdmai_cmd_queue *)cmd.params;
>  	cmd_params->queue = priority;
> +	cmd_params->queue_idx = queue_idx;
>  
>  	/* send command to mc*/
>  	err = mc_send_command(mc_io, &cmd);
> @@ -295,8 +319,8 @@ int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
>  
>  	/* retrieve response parameters */
>  	attr->dest_cfg.dest_id = le32_to_cpu(cmd_params->dest_id);
> -	attr->dest_cfg.priority = cmd_params->priority;
> -	attr->dest_cfg.dest_type = cmd_params->dest_type;
> +	attr->dest_cfg.priority = cmd_params->dest_priority;
> +	attr->dest_cfg.dest_type = FIELD_GET(DEST_TYPE_MASK, cmd_params->dest_type);
>  	attr->user_ctx = le64_to_cpu(cmd_params->user_ctx);
>  	attr->fqid = le32_to_cpu(cmd_params->fqid);
>  
> @@ -316,7 +340,7 @@ EXPORT_SYMBOL_GPL(dpdmai_get_rx_queue);
>   * Return:	'0' on Success; Error code otherwise.
>   */
>  int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
> -			u16 token, u8 priority, u32 *fqid)
> +			u16 token, u8 queue_idx, u8 priority, struct dpdmai_tx_queue_attr *attr)
>  {
>  	struct dpdmai_rsp_get_tx_queue *rsp_params;
>  	struct dpdmai_cmd_queue *cmd_params;
> @@ -329,6 +353,7 @@ int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
>  
>  	cmd_params = (struct dpdmai_cmd_queue *)cmd.params;
>  	cmd_params->queue = priority;
> +	cmd_params->queue_idx = queue_idx;
>  
>  	/* send command to mc*/
>  	err = mc_send_command(mc_io, &cmd);
> @@ -338,7 +363,7 @@ int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
>  	/* retrieve response parameters */
>  
>  	rsp_params = (struct dpdmai_rsp_get_tx_queue *)cmd.params;
> -	*fqid = le32_to_cpu(rsp_params->fqid);
> +	attr->fqid = le32_to_cpu(rsp_params->fqid);
>  
>  	return 0;
>  }
> diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
> index 3f2db582509a1..1efca2a305334 100644
> --- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
> +++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
> @@ -5,14 +5,19 @@
>  #define __FSL_DPDMAI_H
>  
>  /* DPDMAI Version */
> -#define DPDMAI_VER_MAJOR	2
> -#define DPDMAI_VER_MINOR	2
> +#define DPDMAI_VER_MAJOR	3
> +#define DPDMAI_VER_MINOR	3
>  
> -#define DPDMAI_CMD_BASE_VERSION	0
> +#define DPDMAI_CMD_BASE_VERSION	1
>  #define DPDMAI_CMD_ID_OFFSET	4
>  
> -#define DPDMAI_CMDID_FORMAT(x)	(((x) << DPDMAI_CMD_ID_OFFSET) | \
> -				DPDMAI_CMD_BASE_VERSION)
> +/*
> + * Maximum number of Tx/Rx queues per DPDMAI object
> + */
> +#define DPDMAI_MAX_QUEUE_NUM	8
> +
> +#define DPDMAI_CMDID_FORMAT_V(x, v)	(((x) << DPDMAI_CMD_ID_OFFSET) | (v))
> +#define DPDMAI_CMDID_FORMAT(x)		DPDMAI_CMDID_FORMAT_V(x, DPDMAI_CMD_BASE_VERSION)
>  
>  /* Command IDs */
>  #define DPDMAI_CMDID_CLOSE		DPDMAI_CMDID_FORMAT(0x800)
> @@ -26,9 +31,9 @@
>  #define DPDMAI_CMDID_RESET              DPDMAI_CMDID_FORMAT(0x005)
>  #define DPDMAI_CMDID_IS_ENABLED         DPDMAI_CMDID_FORMAT(0x006)
>  
> -#define DPDMAI_CMDID_SET_RX_QUEUE	DPDMAI_CMDID_FORMAT(0x1A0)
> -#define DPDMAI_CMDID_GET_RX_QUEUE       DPDMAI_CMDID_FORMAT(0x1A1)
> -#define DPDMAI_CMDID_GET_TX_QUEUE       DPDMAI_CMDID_FORMAT(0x1A2)
> +#define DPDMAI_CMDID_SET_RX_QUEUE	DPDMAI_CMDID_FORMAT_V(0x1A0, 2)
> +#define DPDMAI_CMDID_GET_RX_QUEUE       DPDMAI_CMDID_FORMAT_V(0x1A1, 2)
> +#define DPDMAI_CMDID_GET_TX_QUEUE       DPDMAI_CMDID_FORMAT_V(0x1A2, 2)
>  
>  #define MC_CMD_HDR_TOKEN_O 32  /* Token field offset */
>  #define MC_CMD_HDR_TOKEN_S 16  /* Token field size */
> @@ -64,6 +69,7 @@
>   *	should be configured with 0
>   */
>  struct dpdmai_cfg {
> +	u8 num_queues;
>  	u8 priorities[DPDMAI_PRIO_NUM];
>  };
>  
> @@ -85,6 +91,7 @@ struct dpdmai_attr {
>  		u16 minor;
>  	} version;
>  	u8 num_of_priorities;
> +	u8 num_of_queues;
>  };
>  
>  /**
> @@ -149,20 +156,24 @@ struct dpdmai_rx_queue_attr {
>  	u32 fqid;
>  };
>  
> +struct dpdmai_tx_queue_attr {
> +	u32 fqid;
> +};
> +
>  int dpdmai_open(struct fsl_mc_io *mc_io, u32 cmd_flags,
>  		int dpdmai_id, u16 *token);
>  int dpdmai_close(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
> -int dpdmai_destroy(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
> +int dpdmai_destroy(struct fsl_mc_io *mc_io, u32 cmd_flags, u32 dpdmai_id, u16 token);
>  int dpdmai_enable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
>  int dpdmai_disable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
>  int dpdmai_reset(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
>  int dpdmai_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags,
>  			  u16 token, struct dpdmai_attr	*attr);
>  int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
> -			u8 priority, const struct dpdmai_rx_queue_cfg *cfg);
> +			u8 queue_idx, u8 priority, const struct dpdmai_rx_queue_cfg *cfg);
>  int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
> -			u8 priority, struct dpdmai_rx_queue_attr *attr);
> +			u8 queue_idx, u8 priority, struct dpdmai_rx_queue_attr *attr);
>  int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
> -			u16 token, u8 priority, u32 *fqid);
> +			u16 token, u8 queue_idx, u8 priority, struct dpdmai_tx_queue_attr *attr);
>  
>  #endif /* __FSL_DPDMAI_H */
> 
> -- 
> 2.34.1

-- 
~Vinod

