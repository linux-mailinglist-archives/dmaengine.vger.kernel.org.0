Return-Path: <dmaengine+bounces-8993-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFWLKAS6mGktLgMAu9opvQ
	(envelope-from <dmaengine+bounces-8993-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 20:46:12 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3A616A6FC
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 20:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDF4B30BBEA9
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 19:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A448E366DAD;
	Fri, 20 Feb 2026 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UBaCZjYh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5121336604A
	for <dmaengine@vger.kernel.org>; Fri, 20 Feb 2026 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771616669; cv=none; b=BMutOWN4SEZL62efK4+z4MVXkSfObUC+oJ9eSwNASBFIrL+PFyJP0sCmvLpyXXMWQm1e0iMbc+XtAZKlZXDptwl2EPiFRMxY6TWjZZThU4M4u7R3amQbC2gVNglCmIQSB7QtCtr/c4ftxaMQvqqicU7MNEYhvxyL7U81YGz1XzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771616669; c=relaxed/simple;
	bh=nrMUARYe9zH+uvnh42t3b56MRQzTw17fCoVToF8PpdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqtyIzxn23h2520u/yoGxF7ePRbMnhgbaYHZBWR4L5zfIxwaXpRUgpd8glzzXwiRFog1Dc50e0yHgdLDDwwhiPOKZrj8/ilsYoY5QvKaVDFieAcu9ED7mszVk/wanyIw9gAZert7m5YWAUiqlsbVc5eDkTJbaaPLlMMgF1UsCS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UBaCZjYh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48069a48629so24221585e9.0
        for <dmaengine@vger.kernel.org>; Fri, 20 Feb 2026 11:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1771616666; x=1772221466; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSXZDM/gkx0IUG06PIqgzfA52LpX4T1tWcsEGgTSFcQ=;
        b=UBaCZjYhebmtmx0HoYd6wDRF5PwLufabAk6jpt/f1SMeFeroWgrq836F69UmJ42NE1
         oGBM1nBbCJa/V0l8fhdl+xwdxwETyovUGIxFGYmIFAzF0Qyg8mHv03d3wiIJNxiBTtoS
         VnvcCeHAsBT873xO398d7MGfIGQvNhYiofkno2oqqIDuWFHFw0UHht3ci5gefmxTckzs
         dM+khfcxgOOsxRUpHEJdhK/XI8EVQUcdR1mAjAuCFFDaUlFsSn+E/qF3V2ehfmUG2x+W
         r9+u86+REoEFTbJs97NeFXTlw0c9b28hwVb1q1BMSad+jYjEWjIIOm6nYQzObYCjifYm
         Tc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771616666; x=1772221466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OSXZDM/gkx0IUG06PIqgzfA52LpX4T1tWcsEGgTSFcQ=;
        b=C8lNDTs515dQMUbYxN5ZCfWDrL4kdlHdGa0dxsXAWardGdH9HDHhqI6Tmvtw1UVQmM
         Vgg6fRahWT5fvVCKA5sWz7hlTa40r7XJtsIDcW6IePVARGeinP8s+wdvLX85i2xq+0EJ
         kw5oNFjdqCFsg9kkrYwRxJueEzfG+BQ73AagLJ0/BlQdJmkgCsSDdC6ItuGbDhVJp+Jx
         N2byDiT9wL9MZMeJbp/FR4By3lotsHzGDDZGoS1xoFh575MlZNkaAsxPFwxcPZYHPPHU
         k/d2tbVx8K8xmJYlToz4AF6xJpWJCM7VJU+pMLnVRz7BsB77Cvi7YDhchZbSav4A9K1A
         qxWA==
X-Forwarded-Encrypted: i=1; AJvYcCW9kS+VZ7aTtP9+bXjiyAQT5i4uZv2nchckEtfxGFgXm8M6VT4PfgZ9HpqIkl5eVuGyq8JUE6xb2So=@vger.kernel.org
X-Gm-Message-State: AOJu0YxudhfDqIZvqHDTVGDJbT+bOfWNld+jrtLKKyl/HNAaqiEZ1mAL
	ysSOFtwL1hWc5YV7hA5VUxVe3gXItyEm+ufFAGlNE3VBHumIEG/AHrVB9PuyVB7NwIw=
X-Gm-Gg: AZuq6aKqscKnBR5r9zmdpbIGnmJ0I/gotJO/9La5g9pfcaPnuaHgrQH2XZ5gZgMUYAr
	pZjXsS7tPWPWMxY0ekQcDzz71mCGml2kBkSaA2+actN4XIYSiDS9NJo48YzGY093BEsv+n9+d3l
	MM2URUs1qzJVvol9iwd5UxLrjcln48uniOypjsM7d3UPjcNVzwhqWikZZxhLhNzoMN87+4lEkK1
	X7NrzFgLNfK4/cIoSDYZrAJ/yEzfR+JYR8wE3JGy91oN9RC6k/b0l6rdjCtpgX2zxrlgeUs+kSy
	70TVBc2FC6uCHYv4Z60tdTlzt9urtWukGC8sP5g+zQzOietC5PhVYCEW1ztAWzYXb8RLom3UiGk
	SzgiTCUhMDLTaSWcBwaWUicq7pfUJMT3SnUgF8IRpx7PjeVoWwkYWuMXup38MGQHYqDGgvKMQN+
	wgkEpQP85kBuU+IxFUaj1f
X-Received: by 2002:a05:600c:8b01:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-483a95ef65bmr11363275e9.27.1771616665702;
        Fri, 20 Feb 2026 11:44:25 -0800 (PST)
Received: from [127.0.1.1] ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3e1b7ccsm24460755e9.11.2026.02.20.11.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 11:44:25 -0800 (PST)
From: Max Hsu <max.hsu@sifive.com>
Date: Sat, 21 Feb 2026 03:43:56 +0800
Subject: [PATCH 4/5] dt-bindings: dma: sifive,fu540-c000-pdma: add fu740
 support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260221-pdma-v1-4-838d929c2326@sifive.com>
References: <20260221-pdma-v1-0-838d929c2326@sifive.com>
In-Reply-To: <20260221-pdma-v1-0-838d929c2326@sifive.com>
To: Paul Walmsley <pjw@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Green Wan <green.wan@sifive.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Palmer Debbelt <palmer@sifive.com>, 
 Conor Dooley <conor@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 devicetree@vger.kernel.org, Max Hsu <max.hsu@sifive.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=851; i=max.hsu@sifive.com;
 h=from:subject:message-id; bh=nrMUARYe9zH+uvnh42t3b56MRQzTw17fCoVToF8PpdA=;
 b=owEB7QES/pANAwAKAdID/Z0HeUC9AcsmYgBpmLl7uWjyst9NuRS1aIz/Ib7QZ9t93JOlcL7S7
 URhvyuXkJWJAbMEAAEKAB0WIQTqXmcbOhS2KZE9X2jSA/2dB3lAvQUCaZi5ewAKCRDSA/2dB3lA
 vZprC/9j2CNAQy0NxThk9kPI7oO063U7arL4shBXYBczeIv0PMoVAI2GBj/GvX3wI6rvS7wIize
 4ndD+xGwE9kRfYGLB8sGc08VRJ9TAq9YSrKeIa8wgDMsMJxer8QcjaFREvZaOn0lQVEcBnzFW80
 k9IDfcsrJccHz9d8lJaI5NmY5K/Kioop6KgoTaNt3eHn2pUS+zPYXFU096YJn5k9ZhGbXXBR6GB
 IbHHX+bZPNFlE9KJ5jXIEx/nVHoSFqEA1Ex9oPomfsB5zkLtuVqtj5SVVcVgB85krcUgWlXdd47
 SLyq1qdlSPiSUJPQgv+AN9W+4qDP5j7eWabhtfep2QlH9bsyOzfS7WRTjWkDdvhQgO/ozOoYAi9
 3KJFuPb3/YXT1FrASEVh0+rYr6SHVLAu8pNYoj4aPrVgKKpctDXZQ7S5nHVTc7nISiKW9ekQTLi
 d9b3l4ojrAKyNfa7emcMJGOZNYAMN4+7gBED5IdzNMxfcbGJO1/eCnAeV/4c0YrZrsYoI=
X-Developer-Key: i=max.hsu@sifive.com; a=openpgp;
 fpr=EA5E671B3A14B629913D5F68D203FD9D077940BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sifive.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sifive.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8993-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[sifive.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[max.hsu@sifive.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sifive.com:mid,sifive.com:dkim,sifive.com:email]
X-Rspamd-Queue-Id: 2A3A616A6FC
X-Rspamd-Action: no action

Add "sifive,fu740-c000-pdma" compatible string.

Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
index 609e38901434..b6c49060bc6f 100644
--- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -36,6 +36,7 @@ properties:
           - enum:
               - microchip,mpfs-pdma
               - sifive,fu540-c000-pdma
+              - sifive,fu740-c000-pdma
           - const: sifive,pdma0
     description:
       Should be "sifive,<chip>-pdma" and "sifive,pdma<version>".

-- 
2.43.0


