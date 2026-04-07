Return-Path: <dmaengine+bounces-9902-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI7UG5TA1GmWwwcAu9opvQ
	(envelope-from <dmaengine+bounces-9902-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 10:30:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 923F73AB5D4
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 10:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1E473018B79
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 08:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7BD3A5E9F;
	Tue,  7 Apr 2026 08:27:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9683A0B01
	for <dmaengine@vger.kernel.org>; Tue,  7 Apr 2026 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550429; cv=none; b=MzyM+n6O/BuTE8zCSZVO8qCORDhuiwx6+sK4DYcVIp6kxB2Fg56zQpSXjXCt2722OcuP6Pu5U0xecbUUKdwwbHJMvnIlW1jvtXmkV+gNGYDJS0OvOiSxEY+8G/ishSDIYTfgWpfjd1GX1Fv9YUI79zW9L3DVK5MMWRfFYh2U3LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550429; c=relaxed/simple;
	bh=uDTaAwhZucKwokovA4IAGAvz5D4PHMwRKPRxuNWbfQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoAWYywUkvn58nJeyArNF/8jDv7DLN4OSZjahBwIAozmNLkhBNd3Hy3Ck38qkUQah+Y6U5dxjPmpNVimP8Kjws/L80tZweQkHiMY0EF0aSQ3KPxJ52fM98Lpw2j+iA9FnMlRJq1qu77YAKS4+iz7DCkWNq7+JYsKkod/7SdubDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1wA1lq-0007on-3F; Tue, 07 Apr 2026 10:26:50 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1wA1lp-00498b-2L;
	Tue, 07 Apr 2026 10:26:49 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1wA1lp-0000000CxyR-2VYR;
	Tue, 07 Apr 2026 10:26:49 +0200
Date: Tue, 7 Apr 2026 10:26:49 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, dmaengine@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: imx-sdma: Refine spba bus searching in
 probe
Message-ID: <6r7ih7wz7xn44c7c2ukohy3fgp3tpo222jh7ocxacccrvywz3i@mddoznil6way>
References: <20260407032755.2758049-1-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407032755.2758049-1-shengjiu.wang@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9902-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.930];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 923F73AB5D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-04-07, Shengjiu Wang wrote:
> There are multi spba-busses for i.MX8M* platforms, if only search for
> the first spba-bus in DT, the found spba-bus may not the real bus of
> audio devices, which cause issue for sdma p2p case, as the sdma p2p
> script presently does not deal with the transactions involving two devices
> connected to the AIPS bus.
> 
> Search the SDMA parent node first, which should be the AIPS bus, then
> search the child node whose compatible string is spba-bus under that AIPS
> bus for the above multi spba-busses case.

Sorry but I've to NACK this, I already fixed it in a more robust way by
checking the consumer sdma node.

Regards,
  Marco


> Fixes: 8391ecf465ec ("dmaengine: imx-sdma: Add device to device support")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v2:
> - add fixes tag
> - use __free(device_node) for auto release.
> 
>  drivers/dma/imx-sdma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 3d527883776b..36368835a845 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2364,7 +2364,9 @@ static int sdma_probe(struct platform_device *pdev)
>  			return dev_err_probe(&pdev->dev, ret,
>  					     "failed to register controller\n");
>  
> -		spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
> +		struct device_node *sdma_parent_np __free(device_node) = of_get_parent(np);
> +
> +		spba_bus = of_get_compatible_child(sdma_parent_np, "fsl,spba-bus");
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

