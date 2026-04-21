Return-Path: <dmaengine+bounces-10073-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGXCF2w752no5QEAu9opvQ
	(envelope-from <dmaengine+bounces-10073-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 10:55:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6B4438718
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 10:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD50A30269C5
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 08:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91620399345;
	Tue, 21 Apr 2026 08:54:06 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35333F8C2
	for <dmaengine@vger.kernel.org>; Tue, 21 Apr 2026 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761646; cv=none; b=qAVo5bwGar02IshymNfq33QniWVKesF7zivSKdNV5bH+R/XkO4lYS1/qDiWUS9HZNFQWXlTlpZ7d5NimUz0+RHjk/IlHUeIi2UNt2XsjxaE26CbCYo0uDps3Kfi6MGGCzuoO/Q+bBB7ZgECqx5dD9V/GAi9Q5ZrjMFZE0ZFAwGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761646; c=relaxed/simple;
	bh=1VFGhArhs378a+u05MFCB1sg8xTb7PgOi9Kl//0M9Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjyrq8Len7d5emqChIS8UZolZVzASsi+mSes4fRknGMQkYlgWs8GF7WdRZuEhwVetlr6lVmT/dd3q0T2PKoAUWj1No7IB3Rj6AORxyYYL+I7qRZD940YktbBSoO3Hzf1tozO4pL6E174cYYwH4QKn9GmWpO33gBaeWt8Z3z5V5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1wF6rb-00075z-7Z; Tue, 21 Apr 2026 10:53:47 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1wF6ra-006TTu-2x;
	Tue, 21 Apr 2026 10:53:46 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1wF6ra-00000006Ixm-3OD5;
	Tue, 21 Apr 2026 10:53:46 +0200
Date: Tue, 21 Apr 2026 10:53:46 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, dmaengine@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] dmaengine: imx-sdma: Fix SPBA bus detection on
 multi-SPBA platforms
Message-ID: <lkwfzz4lia37wv56g6ymzpossm42epz2oylhl7vgdpp7odt23h@vszl4uu2wg65>
References: <20260420100854.2095549-1-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420100854.2095549-1-shengjiu.wang@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10073-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.felsch@pengutronix.de,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,pengutronix.de:url,30df0000:email,nxp.com:email]
X-Rspamd-Queue-Id: CD6B4438718
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-04-20, Shengjiu Wang wrote:
> i.MX8M platforms have multiple SPBA buses under different AIPS buses.
> The current code searches the entire device tree and returns the first
> SPBA bus found, which may not be under the same AIPS bus as the SDMA
> controller.
> 
> This breaks SDMA P2P transfers because the SDMA script needs to know
> if peripherals are on SPBA or AIPS to configure watermark levels
> correctly. Using the wrong SPBA bus causes DMA timeouts and transfer
> failures.
> 
> Fix by searching for the SPBA bus under the SDMA's parent node (AIPS)
> first, then falling back to a global search for backward compatibility.
> 
> Example device tree showing the issue:
>   aips1 {
>     spba1 { sai@...; };      /* Correct SPBA for sdma1 */
>     sdma1@...;
>   };
>   aips2 {
>     spba2 { uart@...; };     /* Wrong SPBA - found first by old code */
>   };
> 
> Fixes: 8391ecf465ec ("dmaengine: imx-sdma: Add device to device support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changs in v3:
> - add fallback to a global search for backward compatibility, which is
>   to address comments from sashiko.dev
> - update commit subject and commit message
> - add comments in code.
> - add Cc stable tag
> - Don't add Frank's RB on v2 as there are several other changes.
> 
> changes in v2:
> - add fixes tag
> - use __free(device_node) for auto release. 
> 
>  drivers/dma/imx-sdma.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 3d527883776b..592705af2319 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2364,7 +2364,18 @@ static int sdma_probe(struct platform_device *pdev)
>  			return dev_err_probe(&pdev->dev, ret,
>  					     "failed to register controller\n");
>  
> -		spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
> +		/*
> +		 * On i.MX8M platforms with multiple SPBA buses, we need to find
> +		 * the SPBA bus that's under the same AIPS bus as this SDMA controller.
> +		 * First check the SDMA's parent (AIPS bus) for a child SPBA bus.
> +		 * If not found, fall back to searching the entire device tree for
> +		 * backward compatibility with older platforms.
> +		 */
> +		struct device_node *sdma_parent_np __free(device_node) = of_get_parent(np);
> +
> +		spba_bus = of_get_compatible_child(sdma_parent_np, "fsl,spba-bus");
> +		if (!spba_bus)
> +			spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");

And yet the search is still broken for i.MX8MP case since this platform
has two sdma engines below the bus@30df0000.

Regards,
  Marco

>  		ret = of_address_to_resource(spba_bus, 0, &spba_res);
>  		if (!ret) {
>  			sdma->spba_start_addr = spba_res.start;
> -- 
> 2.34.1
> 
> 
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

