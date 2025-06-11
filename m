Return-Path: <dmaengine+bounces-5338-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86222AD4D89
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 09:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418FA3A567C
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 07:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CBA23BF80;
	Wed, 11 Jun 2025 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiRZn59i"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B32D23373B;
	Wed, 11 Jun 2025 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628481; cv=none; b=jodW+4HusBToZURl7dKVrJhFaLqXfJ6ngyZaG4Ipe+MIvNhaut925ewlBDMqFdJIpi8VnLgy8/R10rf+ZBoSqPmFCl0CYFshJvsT/JLVu8OOhk9BDgNG2S1X3ZUkPhS6njFxXPQm16n2ee5Io2rQR3HP0fkB/rlJhaWGa5zwkDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628481; c=relaxed/simple;
	bh=leYEMODDBviLVcx7yoQ0Zt5ZI1j1sck0Bv2d4cc1ysQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9793L1FCn075R2easaO/OK2OlNTarZd6sCGQwl2yX4jDI0OYugLbN4jbnDeWBP0p/pEabyn3+LVlW+Z/iDB7iktsoKWe7x6mMVX4zk3WVv8d5PF+xmnhfCETAPyWQTsgbSQgOQOct/h19nuwC3MD/McqhXm8nmy8GuM5MrPQ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiRZn59i; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d38cfa9773so384255685a.2;
        Wed, 11 Jun 2025 00:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749628478; x=1750233278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TucqLG/tk3Y/USNHaS48EdntTVxxdA1FanRm1k8rL/8=;
        b=YiRZn59iIGvdM3HzcD6U2ldQ5wwGfQyZLr8TQKnWBPDuOwkfWgrOblNVEG9hBNWo+e
         MUMg/QTqttkyCZQpzuJ5FLDbRsqX5Bj4FJg59wOgCWItPi4fFzuZO0wwlKs0Qm+p65dl
         SiwjyRxSvklm3EbPgJDFVtf5KBHcbYL6LcmvTqFvcKf0KvSGwRCU4nnVWfun3F6Rqz1L
         u0bYDWMPiMRNQM3i6hOy2yfWiyk9zhs7Y6KDWmSzNTDUYLP7RX9ardwG/mVBmIE9cjhN
         kWOUSbKKRhHzKOo8liYthc9+e/0pflsO1NbhbmiJbIqd9PBO757/0s35YjXMLd71Ir7B
         Irpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749628478; x=1750233278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TucqLG/tk3Y/USNHaS48EdntTVxxdA1FanRm1k8rL/8=;
        b=RgsGgUdbH9FjxRkU7H/oU9QU7CFMILydO/GtVrwXt8+xIacLzwk9WxmLmFERa4RfFp
         SLQZTxF537LgDvsNikU0WB+894dmfYWawvuBZ7RClZL/iys0ncTsMh1kn+Uq5cjA/Kxu
         gDzCQd5qffoN31tjemGOt7DxETwVmjOMw69Oe/89rquEvwgJcXiMY44ALXbcgDVLEP+c
         f8wU55+S28OcfwOdRCezQIJabDQeV7WhTpUdjQJjQWrk7zaLa79I36Ffki9Ppv0qza4Y
         +T28CsgBbUY0BnpfgGTMq4HKnGQ4r5BvRxIOFKEr6DINZKIxziQF4WTEO6pjFnNktTso
         lSBA==
X-Forwarded-Encrypted: i=1; AJvYcCVacsn52fsXISi0WKQCQTZVayaC1NEDH0qpG5nz8/Eu2ZWZcACRR6J+OWP35W8s9u0d8DFGN+qrbg5I@vger.kernel.org, AJvYcCVdQ5amXC3VsJ9ZXxGlqgi+FbVQcDM9fuRmqtZWfja6H90AmSD7UMPwP+9H11WiNZhn4OAwkzmvkFh3@vger.kernel.org, AJvYcCXNCQW8I1NJM4jHO6ck3Y373lqZvqzp8tIvNlXH9grOmp8VZGcB30BwDxUJkAgMQiACFrN+UqXk5xr/j7MG@vger.kernel.org
X-Gm-Message-State: AOJu0YzS4Ih5jbZJiwkaIJEv+74G+eiTXLLdi+xgyB3wUUGmS2MOoN+f
	AY4o97pKYiyalm6RNfo01mnxPQGYXUK4CZeL3ky/zQ6DekUMXfb9wk2P
X-Gm-Gg: ASbGncuPoTNAszlCp/8U4+LzSdgaA64UTuzQpa93Rt4zqzGdbH50MnhpRLWJJ+hRnDX
	0a4uCAtTfIGKDeAcPStBKAV5DV9Mizdxitl4+NjUJAv/QwlskS9ZM1huSgY0F9BmgSkI7Yr6gUo
	oiSDd/RipRG8Tt0mC5leWeEk8PxcfyLpof8ji1c01jT7m8QccaWOBplgiyB50LDkJeA57/HCci/
	Co8wyYJcp2+RY6W0++nSaTmsrg09Brk7zwvS5LnoQZY0dDBpvpsbr+HKGFSSlOMfP99OQ0l7JBZ
	qESQdd865AQYzRfioVyBwbB/ksSZtnwM9qTL6ZziQdGIAOAG
X-Google-Smtp-Source: AGHT+IEySdwciKZhGZrTCtsR/Gxqu5FAFCLHguwmpefzLwsb16bnu8UFs0/XpS23i1fk+Kd0aatnNg==
X-Received: by 2002:a05:620a:29ca:b0:7d0:99dc:d026 with SMTP id af79cd13be357-7d3a88057a4mr312939885a.12.1749628478269;
        Wed, 11 Jun 2025 00:54:38 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fb09ab8a3csm79057766d6.10.2025.06.11.00.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 00:54:37 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Vinod Koul <vkoul@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yu Yuan <yu.yuan@sjtu.edu.cn>,
	Ze Huang <huangze@whut.edu.cn>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	dmaengine@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 2/4] reset: simple: add support for Sophgo CV1800B
Date: Wed, 11 Jun 2025 15:53:16 +0800
Message-ID: <20250611075321.1160973-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611075321.1160973-1-inochiama@gmail.com>
References: <20250611075321.1160973-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reuse reset-simple driver for the Sophgo CV1800B reset generator.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 drivers/reset/reset-simple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 276067839830..79e94ecfe4f5 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -151,6 +151,8 @@ static const struct of_device_id reset_simple_dt_ids[] = {
 	{ .compatible = "snps,dw-high-reset" },
 	{ .compatible = "snps,dw-low-reset",
 		.data = &reset_simple_active_low },
+	{ .compatible = "sophgo,cv1800b-reset",
+		.data = &reset_simple_active_low },
 	{ .compatible = "sophgo,sg2042-reset",
 		.data = &reset_simple_active_low },
 	{ /* sentinel */ },
-- 
2.49.0


