Return-Path: <dmaengine+bounces-9097-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCJiLf4rn2lXZQQAu9opvQ
	(envelope-from <dmaengine+bounces-9097-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 18:06:06 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CA62019B37F
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 18:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC355300A659
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355D73DA7EB;
	Wed, 25 Feb 2026 17:06:00 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB53DA7FC
	for <dmaengine@vger.kernel.org>; Wed, 25 Feb 2026 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039159; cv=none; b=piNiBdwEWvzhl8w3Q023epwAYnMs2yVOKCDg8G5SB/jYlHGKrlLRcIzYQ5pO4+YPJRTcxo5YnKhpjViQm/or1J1O8E2wLjN3g/etlsu6iwnf3Nhm+VIRkZy6esCd2zpJV9rMpuMV3TSFOTSRQx4UiOp2SdY22aFoI+8KIOLC6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039159; c=relaxed/simple;
	bh=BS+8jvv2hnhJcsZQrv6FY3QrasBPQnLs1PnQ9kutfQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvwLzHz6K3SAz5XfRqabGPK6noL+WCuZMvM95xfBi8uQzfQgJ7PDjCDPcuqT7vxnAJueYN8i3BUaIt+N05d76gJfvWBAIJpx1vOtceaWhS/bLcrVDz5l77uznN0+xwz47Eimi8s2ZcSjE5XNSjBcCC7aAKU1YNgxOTXpUvz5quc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vvIKL-00010T-QT; Wed, 25 Feb 2026 18:05:33 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vvIKK-002avE-0S;
	Wed, 25 Feb 2026 18:05:33 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1vvIKL-00000004yoK-1Zi3;
	Wed, 25 Feb 2026 18:05:33 +0100
Date: Wed, 25 Feb 2026 18:05:33 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] i.MX SDMA cleanups and fixes
Message-ID: <4srixmuzaay4tetvlgribjtri5rm7akycy545vrg3d62ifmjsg@iflrkv65u3k5>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <aZ8cVP7E-BOEJKFu@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ8cVP7E-BOEJKFu@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,mentor.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9097-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pengutronix.de:url,pengutronix.de:email]
X-Rspamd-Queue-Id: CA62019B37F
X-Rspamd-Action: no action

On 26-02-25, Frank Li wrote:
> On Thu, Sep 11, 2025 at 11:56:41PM +0200, Marco Felsch wrote:
> > Hi,
> >
> > by this series the i.MX SDMA handling for i.MX8M devices is fixed. This
> > is required because these SoCs do have multiple SPBA busses.
> >
> > Furthermore this series does some cleanups to prepare the driver for the
> > upcoming DMA devlink support. The DMA devlink support is required to fix
> > the consumer <-> provider issue because the current i.MX SDMA driver
> > doesn't honor current active DMA users once the i.MX SDMA driver is
> > getting removed. Which can lead into very situations e.g. hang the whole
> > system.
> 
> Marco Felsch:
> 
> 	Can you help rebase these patches?

Sure, will do.

Regards,
  Marco


> 
> Frank
> 
> >
> > Regards,
> >   Marco
> >
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> > Changes in v2:
> > - Link to v1: https://lore.kernel.org/r/20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de
> > - Split DMA devlink support and SDMA driver fixes&cleanups into two series
> > - Make of_dma_controller_free() fix backportable
> > - Update struct sdma_channel documentation
> > - Shuffle patches to have fixes patches at the very start of the series
> > - Fix commit message wording
> > - Check return value of devm_add_action_or_reset()
> >
> > ---
> > Marco Felsch (10):
> >       dmaengine: imx-sdma: fix missing of_dma_controller_free()
> >       dmaengine: imx-sdma: fix spba-bus handling for i.MX8M
> >       dmaengine: imx-sdma: drop legacy device_node np check
> >       dmaengine: imx-sdma: sdma_remove minor cleanups
> >       dmaengine: imx-sdma: cosmetic cleanup
> >       dmaengine: imx-sdma: make use of devm_kzalloc for script_addrs
> >       dmaengine: imx-sdma: make use of devm_clk_get_prepared()
> >       dmaengine: imx-sdma: make use of devm_add_action_or_reset to unregiser the dma_device
> >       dmaengine: imx-sdma: make use of devm_add_action_or_reset to unregiser the dma-controller
> >       dmaengine: imx-sdma: make use of dev_err_probe()
> >
> >  drivers/dma/imx-sdma.c | 181 ++++++++++++++++++++++++++-----------------------
> >  1 file changed, 96 insertions(+), 85 deletions(-)
> > ---
> > base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
> > change-id: 20250903-v6-16-topic-sdma-4c8fd3bb0738
> >
> > Best regards,
> > --
> > Marco Felsch <m.felsch@pengutronix.de>
> >
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

