Return-Path: <dmaengine+bounces-6302-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13935B3CB39
	for <lists+dmaengine@lfdr.de>; Sat, 30 Aug 2025 15:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FD7A03D81
	for <lists+dmaengine@lfdr.de>; Sat, 30 Aug 2025 13:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB465224AEF;
	Sat, 30 Aug 2025 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFqongrE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A151F4C8E
	for <dmaengine@vger.kernel.org>; Sat, 30 Aug 2025 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756560410; cv=none; b=OFuU2iW85LX1smNZYWhR6XnHt3VHA0YTwANyJZMjpqCRub8KOTYdiEHJA1X5n/tWmvKCRWD9PP5t0bUifgwZHcxysa0A3/jyO92ycI0VPJK/EtTx8opu+S1K2W6bE3xUYbedrnh4T8NGCH1n3uLpAsiGSIHSjxMK0zTpiCQy7iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756560410; c=relaxed/simple;
	bh=2izd0kceAmlc4wGTcooA5uDIAJkg31ZnD/ThRwr30Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ge2U4oLtCfGyaIhBTyqnPY6qR/Fab6ocfCrMIT41KvhnpWp72z4v/pocw9O++2KYxSsMd4Lany5jUw1s7oPU5NsruqzKKITVsJP23FHJ343cNvReLZd40TQVUhQco8B8jQOPzPPNhKRAPnRrurgZpfAqBSmKJDc/ZNsJzd/Ymcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFqongrE; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70ba7aa131fso31607586d6.2
        for <dmaengine@vger.kernel.org>; Sat, 30 Aug 2025 06:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756560408; x=1757165208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QS8izAcIpePONpdRiDr0Q2OS2iBDSnSdZTmJA4AydsM=;
        b=mFqongrEIA3VKi5r5pPjiy1pJthdYg6BWOW8IFeyyRsw3PWzt1lO0qp/d9/NS+mebf
         662+hjoxf1Q3ED5eTVqnPMbOuwEKeC8SZ6CT3RzexBH1wLezijaT5lgJXQLWVZNKuZ/1
         i2w2uHmtrDNnATdy2KwQzjbxtiaPIBl2hH2Obbd5X9o4HJV6+59jh/uapLD71JaU4MZV
         JVH943zt9vw8j6zMl7PHHCi7ENl5qH89OlnHy0hrI51j743JnsTeoYV7HtpSWugkwSX0
         0QImL4LH+ibw0V3D6b/JqmnXkLDL6QObuNNnixrhy7jq7OaTJO8Uj7H082LfQ1qAebWH
         m7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756560408; x=1757165208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QS8izAcIpePONpdRiDr0Q2OS2iBDSnSdZTmJA4AydsM=;
        b=r7ZvinOSzvKXBMSw6AaatujJDLi8deCqWapHLh54wMst0LMaovfYvleYFZdTr+sGZK
         i8XmKkyog2dJIMSqLuSUXcHkOuyYp00gYbJbV6hnPxt1cqLrxLSH/IMMiv1EAViK7Fxc
         BL8zvcWzUhCbl+voP4umJ5TaR1MSo8Nw05HWxJyD1G2gb3kedv/dUc/RIdl9fIVS41e9
         lLQ8rTG9jOmBX9q/bcxiAxYunZifYOM2c9Gvtpv7k2qCzTKsiRDgIk/JB3ysqM+rpCMa
         g0x99wxitI8L+iIGawe7IU7ATLRUhsKix55iw09tD4Yt9uPHrAZq2UBbcxFJTAlJocw7
         ovfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/bk2H89hkrmSUarWk+HeHNeXvpOtI6OwCbWFrwtyBy3Eo8jSnecxdmElurMu80bFwka4oeBECF00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj+owt2kStTHxXDAleFt+BFcyrCRmmv1IEtjXCZkXZIweybM+l
	mfuruNlHXsDwVMi0G5nrvznzzuxJtxlB4l9S4HOZ+H8/ZbVdfc+H4kKN
X-Gm-Gg: ASbGncuOn3hO/PDeAgz2aFQndeZ2k92l7oV7Gb0Pd7dbn/o+Yf0pX+s7PUryIkBi51v
	NQ1U0SwS2fhnH8e3FS7d8KOTAQnYD4GFmsW8MEo6zvN1og7IqUBOt4d/rLbiOGJEmEyk1W2EAPg
	Zhr5spqkxJXBROtOgMf5YACTAQiD4oO0yomXe7JORDVNefDaFht1buOfpwFQYN08VNDQrQ+tIWt
	ULBkqLGeuKsJP31bmhbZMqjmasTAK/vyoNSMJXCw8HWYUMgF/PA+dw5NTK3w8eFOFtuWxbyHlfm
	fkmvzPavr3NQDbaVi+OnnSD6pnRvzBOgj1tgGhJAxy/T1ZfiKtR4yHUkodYB9ffexqi/Ec4T8ef
	AvS9FO5mZ/0/bBrcaeLvSL4z3eeGjijpbrISDSWhz+tlpQoaxpQYDIfGHth8ody+lr4OQ
X-Google-Smtp-Source: AGHT+IE6zrU6iyUqcFmJvQ9qSLszP/NdRcQFyUgfus/aUtp96mxi5yjEyOyOpURIPS+atAgLgNl/HQ==
X-Received: by 2002:a05:622a:1812:b0:4b2:94e5:9847 with SMTP id d75a77b69052e-4b31dcac538mr27405641cf.74.1756560408196;
        Sat, 30 Aug 2025 06:26:48 -0700 (PDT)
Received: from cr-x-redhat96-nsd-2.fyre.ibm.com ([129.41.87.0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b6b9683sm30936871cf.39.2025.08.30.06.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 06:26:47 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: vkoul@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH] dma: Replace zero-length array with flexible-array
Date: Sat, 30 Aug 2025 06:26:33 -0700
Message-ID: <20250830132633.1803300-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/process/deprecated.rst suggests that zero-length
and one-element arrays are deprecated, flexible-array members
should be used instead.

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
 drivers/dma/imx-sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 02a85d6f1bea..ed9e56de5a9b 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -256,7 +256,7 @@ struct sdma_script_start_addrs {
 	/* End of v3 array */
 	union { s32 v3_end; s32 mcu_2_zqspi_addr; };
 	/* End of v4 array */
-	s32 v4_end[0];
+	s32 v4_end[];
 };
 
 /*
-- 
2.47.3


