Return-Path: <dmaengine+bounces-9991-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHdzDXo12ml9zAgAu9opvQ
	(envelope-from <dmaengine+bounces-9991-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:50:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A23FD3DF9CD
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02F2030AA850
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 11:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A0435AC1A;
	Sat, 11 Apr 2026 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MLKtE0J4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B917359A7C
	for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 11:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907812; cv=none; b=AQAvhzhM3o42g/Pjjy/r99ZlZv4oh9eT5h+37NfpPWzIpUjC2PJuYUbG+d4PsGXcePA8TGyRMLQXgeN3+aYzj2BLR2FofYYYhvxRffJO9iuWn3UxcvavY7sPdSQAi0qUn7XmzTX3TlOM8DO81VLBBkQVPqv+irJwHkOi+7sEoIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907812; c=relaxed/simple;
	bh=IW52sWUaqMFEY6BbWKKClK/wbgEBkQeALR5hdqMA95U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O32F7G2ZZ8enPAxcY3wNleP+SfDQf8u41SGLSLMzP3DpTmfWJK8kY6ZNVoUlC+MCM3fadSlxxYHlHjI8HPVGt/v9jdEZE1ERsAFI50R9zqiZNqrySsuLYryzwdUZZ8wILJXzVH0BOq2POPcFfBYpSRpTxYYidFd0aw09XRhBHUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MLKtE0J4; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d17bb1c65so1906470f8f.0
        for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 04:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775907808; x=1776512608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zdkb0CAXfpSevM/ivqXKAKRICDyAzezyAIbw20Wd9A=;
        b=MLKtE0J4OBmPZxXaz9RiZvRq2+nnNzXMbYGy2n/ectLDEhjHo+XxPM0s0XkB3bgoxl
         i7N5QlSfHqxhen27HErppclZvCimwOzUem7Y2LcVjnq/185sRvBR/vaeucKJmz6bI/pI
         IlFb/uBzOJQkaeR0MUy7rHiJoKYOjqtQOl4e/RmbL5sIFRIBpnY5R5hZeVp/Rc75TdE+
         HbXItGGWO72c+P5Tc8RnXaJUb+6uaZhQntmBBlXhTjw9+ya+r76Tr6PbpDRq7YBWLgE9
         T5uXW66wI9fKsMgiWfXtFf+AwhZlTMEfZD+gRfOzl/4CuM7Q/MhrpbYdmjzaqV269onT
         BVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775907808; x=1776512608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3zdkb0CAXfpSevM/ivqXKAKRICDyAzezyAIbw20Wd9A=;
        b=LCXixErHwGH+ediA32+zALQHj+cKJSZbnpiDDQQpwnxDOhR76QH/UqVIHArRn/DgwN
         DxGjVc8g68ZJC6PZAvR83bpnmBfhmQ4A5h5B4qI/F4wpcCSqpWpQ76whr81p7HhBmlog
         uyYVKeQcsaRAFdJefe9PkEOJ5FBwaq2MAwUnyfZLA+sEO+xfStsDK96aCgCY7tpaiOq7
         Y4UfUAv2kpBUWwovAVpmodstBQhqQEN8BTJvtEZdt4rvRCSNs2dYaksb1WwrPcqgxhVq
         AbUeFAfcrM4JnXe0zXIj1meZiaPqHOHi2Ts9DMAHwfI4v0b85gmJSkGBUI3jlpGoLGUF
         ioSg==
X-Forwarded-Encrypted: i=1; AJvYcCUE/3Ud3Z3NlblQ5O08jUyRWdjeeVqKEQ32ncFQPxVSlIaV0Gy268HYHnZYYCgssP37m6N2xLuODU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu+jxOdoc8iXvzS6AgNEAb7YISeVjwv49GpZXpsxPfa1KT8POf
	HHEun7PbnmkPMSag1O3T0QU7hendzqp7nUeeflAjIKOm3kTjHXoKgIKzJwDazejR+oY=
X-Gm-Gg: AeBDieudouADsP8+VXfO35p4cUrvHANH8r5jHK4OkhFMcCi9hrUqIYo7LVikaMINEpP
	hrY5LFQ+txQxmg9C9hn5tMheu8AzEVSAhfH7EtgcmYst02ailJfDUnn5FSUK6iENbP0xrUVOwBo
	QJUXqIiVgCnpON/hQzKHFTFMPADvKOwG7xL/n1/YG/4yvIso243SmrBpKZ9WG57BLyrj/9NwsZz
	XG6p+v/ZoFXIq/K0uW1+mXUlywvDkRJP906KynVNd1AdRNeJKeqkeGi8EDj884vyWRbrA+mhNVs
	PUu2orBqmihc3TqX4P8AUar2zvhVR08jRBG9Ebn//65UFAF+l04cfRn2LUtvMj9MgVPTEuttRWA
	cH3o1yq0IlJGPzdfIe7JYdgE2AQuitifEJL1P1Y9+09zbN+igJF4Q/nhXxcP3yePFCzzCnsn/MH
	ZIp8cu8FBkQIvrOKloExOXGrL6qjVLB7UxjANwivFFr6nxCDbXDudB
X-Received: by 2002:a05:6000:2304:b0:43d:1c3b:2dae with SMTP id ffacd0b85a97d-43d64255160mr9442521f8f.9.1775907808486;
        Sat, 11 Apr 2026 04:43:28 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm15776447f8f.33.2026.04.11.04.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:43:27 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com,
	long.luu.ur@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 12/17] dmaengine: sh: rz-dmac: Drop the update of channel->chctrl with CHCTRL_SETEN
Date: Sat, 11 Apr 2026 14:42:58 +0300
Message-ID: <20260411114303.2814115-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9991-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,bp.renesas.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tuxon.dev:dkim]
X-Rspamd-Queue-Id: A23FD3DF9CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The CHCTRL_SETEN bit is explicitly set in rz_dmac_enable_hw(). Updating
struct rz_dmac_chan::chctrl with this bit in
rz_dmac_prepare_desc_for_memcpy() and rz_dmac_prepare_descs_for_slave_sg()
is unnecessary in the current code base. Moreover, it conflicts with the
configuration sequence that will be used for cyclic DMA channels during
suspend to RAM. Cyclic DMA support will be introduced in subsequent
commits.

This is a preparatory commit for cyclic DMA suspend to RAM support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- set channel->chctrl = 0 in rz_dmac_prepare_descs_for_slave_sg()

Changes in v3:
- none

Changes in v2:
- fixed typos in patch title and patch description

 drivers/dma/sh/rz-dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index d009b7607d44..958ee45abc70 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -377,7 +377,7 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
 	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_no);
 
 	channel->chcfg = chcfg;
-	channel->chctrl = CHCTRL_STG | CHCTRL_SETEN;
+	channel->chctrl = CHCTRL_STG;
 }
 
 static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
@@ -428,7 +428,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
 
 	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
 
-	channel->chctrl = CHCTRL_SETEN;
+	channel->chctrl = 0;
 }
 
 static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
-- 
2.43.0


