Return-Path: <dmaengine+bounces-10283-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMukM0J5AWpGaQEAu9opvQ
	(envelope-from <dmaengine+bounces-10283-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 08:37:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 642A15089A0
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 08:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C24DC30041C6
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 06:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34332FD1B3;
	Mon, 11 May 2026 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoOR1mGc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA01E0B9C
	for <dmaengine@vger.kernel.org>; Mon, 11 May 2026 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778481472; cv=none; b=RnXsVYQhP4ziD5o3GdkRZdOmJbM4sH8F8IZs6lGdPJlfktDSHML+2pe50Ub/nXqChGUgdEaypgucdkprLoOq3+RdM5KlEDN7lVbeVMsbvs5aOTqHPViJMcyS87RucTbUqvAEu8n9kI0MwgquuKTwcsJsvLtEj4u80m8J6yRfbxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778481472; c=relaxed/simple;
	bh=wh54+hFJBmFzdbHocxMQI0mfnlei85NeRSqpfU5DbWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TXfUp/9Qywt21VuDp+sN6O+WPq9UPrFxzjIgQdgkaaL2UB8lR9xsPMbee8IGl3k4W/k06u9rloCw225a6LqLCXI8BFVfUxWBN1CSIL6zqUxUM0BMDfs6sB5Atu6l6T7JG3se7peLEvcwG0GoRMnTsuNIeljgzuOEP9vyCDQDCgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoOR1mGc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-824c9da9928so1642088b3a.3
        for <dmaengine@vger.kernel.org>; Sun, 10 May 2026 23:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778481471; x=1779086271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hG7re9nWf1eNGkdto4Ixyj7RYv5HNsRc+oGfPkcFdsc=;
        b=HoOR1mGcNQ3ZbHnLo/65srboBtdxpvwyDfWirvG9Aw6KRDCnqGOqJf/MGzE/FypGyQ
         Ou1g928Hl677bYIpqApuZ+4NOSnEnpDfftfjTIUlCsFl8kdR0fBnI/urBS98A5m8A2Oc
         2PXdgKdwv+YaDidv8Icf6iirytroihgT24I1g6HWsZHF9YXv+Eus39QRxbaKyTMi5Uw6
         FQRQDQm+dqSIt215bPof5EeNuxtlIQca/smOQU/Cop0WWY2sYugM8O2dHb+UOiuRu5vS
         rnnbOxzPlWsd8wAi4hgAi3cNeU9hpm+CGo1CWJkQB8jl6dSIhJxftKBfc3bblEHFIElb
         z0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778481471; x=1779086271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hG7re9nWf1eNGkdto4Ixyj7RYv5HNsRc+oGfPkcFdsc=;
        b=lIrW/StibYR5RIe9zdUc4JwFD9osiZSqpt6ZKi7pi2hs6VifULfgBhtbcqhcQr6s9p
         em5hgBEHsoPr2SgTfsFcXnDB39IXCXOvKJKDT6D32ja8oqbBI4tL3jDTHNHhQKAhbu+z
         a16QAHGb03fmWX6KQdPcQx4qKUdM5BpqFIw5vL2xbJW/UPbR9W16nq4pCSPrptTltMtq
         jqw2L+qBBdOb7xYupkTRd7zwn6xqCK9252xlqG0+sDzAF/7kgi9CRDGBa5c3H3yte8Bl
         wxcoHybOrGOeTse0ry6j4FmrGN1O75gumi0wNQ3wAA30WR8mrIZRF8qdi55PeAnlBNbO
         ctFw==
X-Gm-Message-State: AOJu0YxzYuMAvNdrX15UmNv8psuJ+U1rrZBhyz9Hv+0d3x/Lg8ERwP5A
	WH+qjBAdt3LD+O+TNVyYQzLtqiqv/xbaGex3TJS7BCwpsBa6kVOdU8FL
X-Gm-Gg: Acq92OEn/CGI8S+J6gOwMNiwIF/pkEn39BDhytPIcGIQinqGgxLhzSKSZe+fjGy5tk9
	X2FpfAjPmmigiRUNBE5/yHnEU3f9Gt+q6mNPQUHE8ExjTAr5S/BVbMBOg3HaHAhoUyCBe5wVSNf
	pPLKN+6ew//JEWVlJ+iCiv6YymEADcryHHUB+5iBCdW+JJ9u3LkJ5frQh3oUVXhGWYHBVLyMDi1
	IVI2vas52frnlotUwl8at/oyl4slEFsEmWbnf70MlzeNT9OaIkZ2qKMxqJGeoyUxgkI717VGesB
	7yQKV0hUuOg83RFkH1sXtJ0AnJbCFsGuLkiFXRgkfQZj/JTlXDxZzO/3dUeEekof9lZ1kK4KPST
	T/fHTWexEjyaZlRSTSjIRn0Yqc32Bo3VEbbJdNOiEQx6yuWk3Y+2c5Hd1XQtpK2iS+3HVpv5tc+
	FeU8lKLLZEdkl5PVS8SmISSjd41vOoYFT72g==
X-Received: by 2002:a05:6300:218d:b0:39f:8b01:d968 with SMTP id adf61e73a8af0-3aab12eab37mr14600912637.11.1778481470932;
        Sun, 10 May 2026 23:37:50 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82677104b8sm7992570a12.19.2026.05.10.23.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 23:37:50 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Longbin Li <looong.bin@gmail.com>,
	"Anton D. Stavinskii" <stavinsky@gmail.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>
Subject: [PATCH 0/2] riscv: sophgo: allow DMA multiplexer set channel number for DMA controller
Date: Mon, 11 May 2026 14:37:16 +0800
Message-ID: <20260511063719.460049-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 642A15089A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10283-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,outlook.com,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-0.986];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

As the DMA controller on Sophgo CV1800 series SoC only has 8 channels,
the SoC provides a dma multiplexer to reuse the DMA channel. However,
the dma multiplexer also controlls the DMA interrupt multiplexer, which
means that the dma multiplexer needs to know the channel number.

Change the DMA phandle args parsing logic so it can use handshake
number as channel number if necessary.

This patch series add fallback compatiable according to the disscussion.

Link: https://lore.kernel.org/all/MA5PR01MB1250079A8884D4F6245B955B9FE51A@MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM

Change from v5:
- https://lore.kernel.org/all/20260426012921.673953-1-inochiama@gmail.com
1. Add dt-bindings patch for fallback compatiable
2. patch 2: Adapt the binding change.

Change from v4:
- https://lore.kernel.org/all/20260225104042.1138901-1-inochiama@gmail.com/
1. drop patch 1 and patch 2 as they are merged
2. Add ABI break statement and clarification for this patch.

Change from v3:
- https://lore.kernel.org/all/20260120013706.436742-1-inochiama@gmail.com/
1. rebase to v7.0-rc1
2. patch 1: Apply Conor's tag
3. patch 2: Apply Frank's tag

Change from v2:
- https://lore.kernel.org/all/20251214224601.598358-1-inochiama@gmail.com/
1. patch 2: rename "AXI_DMA_FLAG_HANDSHAKE_AS_CHAN" to "ARG0_AS_CHAN"

Change from v1:
- https://lore.kernel.org/all/20251212020504.915616-1-inochiama@gmail.com/
1. rebase to v6.19-rc1
2. patch 1: remove a comment placed in wrong place.
3. patch 2: fix typo in comments.
4. patch 2: initialize chan as NULL in dw_axi_dma_of_xlate.
Inochi Amaoto (2):
  dt-bindings: dma: snps,dw-axi-dmac: Add fallback compatible for
    CV1800B
  riscv: dts: sophgo: cv180x: Allow the DMA multiplexer to set channel
    number for DMA controller

 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 5 +++--
 arch/riscv/boot/dts/sophgo/cv180x.dtsi                      | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

--
2.54.0


