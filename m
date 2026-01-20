Return-Path: <dmaengine+bounces-8388-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B802CD3BD00
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 02:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00958302652A
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 01:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C0824677D;
	Tue, 20 Jan 2026 01:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1DEZHpb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3470119CCF5
	for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 01:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873041; cv=none; b=u3n2QksEIwP/ZLKEsg6XjxAF2De2NKCi/HLszmbjqC+QJJrE3au3QBfzkWr4mV91rOelN+UNwQivogf17zqcLa4/WUHfzV1bUorqVD5V8/mlXRZnWnBJ/hR7tkOn60VAkx2ziQv+U6+mAIIjywO1KvJTc/ZiDGOe8qdZFkf3ElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873041; c=relaxed/simple;
	bh=6foIMWkM39YpRsrHkcMuBplG96nIcvxZ8pyBc0baPBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2xIVMItIPYIydpKeP3MgWIfdLGsxMsUSv91qd2c75o+xdY12fH77Do/0SZPXKZTwjtrGFezuZjI2voN4MoP2pGvN2vDm+QxqvVwyUtKUbhQKFwwiOcQHjA19ckHXnPLAIH8Wkri7QDe/iNps3ynYKnRcmMxrSgwmOn0DcnYmy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1DEZHpb; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12332910300so7170510c88.0
        for <dmaengine@vger.kernel.org>; Mon, 19 Jan 2026 17:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768873039; x=1769477839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2L35WsEaTxvf/DBI91MAjfu5hKJ1Z5i6X+ns/IiMxg=;
        b=j1DEZHpbxJkY4ARYa9Cu/trSfer8Tv3sCDvjEfdHSb4sJxV74K99eoE8fSEOJFQOJ0
         lGCDo4Vk1vGoP+nTXZJnJ5kx18OQ35rMKhGrljIEYZYlguMb82sI8/Lj1E5JnDK4PTH7
         IlIn3xvjKR6hfIO8hE+6ng85ImJihaEpDD/8Q2EbJZAa8ywTa0MWjqRyiAKl3mnq7Ilw
         2BZp5cV4EmhhzUb+WMbYVC/L+Aaonj4w/nK3eqSdVWFLKLQsahI/xUTeHM265f/MgGAT
         9ujLSHXI3l6OKzH2nBO3r2Atobs/fLoiF0kkuQPuSRaanfsV94FlVBxUYj84NicBgcZ1
         K7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768873039; x=1769477839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c2L35WsEaTxvf/DBI91MAjfu5hKJ1Z5i6X+ns/IiMxg=;
        b=PN7txivUB1/7WvYLGT5R7PT8U2qBEHu20kmGElypar+SkzgP+lHh2n+2eDVq0SncBg
         14UjynKG0bmlwwuqpcF1kyD8k1pNEccX/9mC4M4bwnF6PGZtJ3RELMvKat+opr6ToHme
         YqhfrTU3krJb7QMyZXydNA4BcbC1/Ke68W56BG0sFfDP36jK7lmMKDyhk0IraUjFVjT2
         mZX1je16UO75QGKRYW1B7irSLsB324SEFWe7Sc8xnkdhey/5nwEx/fkPTPp/gtT8KUoW
         zEzLErI4UODAvbOWjIr6r7xHef4cRT3mpE9TgBnixfep7U1bS6PAYLWfXf6k2cal7+De
         6dXg==
X-Gm-Message-State: AOJu0YxRM36Pt5tkHu+vVQIJ5SqdaHO9QEXa1CB0SDgZZ3W59MobXhrI
	+QXLMbCA5ws1WpGNCvNB4IdQb7dyUTZ7jWJCOF43Pr3wUhw3GjyrUgjI
X-Gm-Gg: AY/fxX7NJpBk5Vo9q8LicMsmZSWjmSKsK/JcgmmpIldj4pCRUz207j3Mw5juBAQh7OC
	WrEyVD/8ypUX89tJIm66G3phWC4rNld6oAU3tu4eNowfA9Bq++hFv4B/ONegnEr0rCtlN1pwsri
	gGHwpg2WgFOMwtnqBD249phpDZva88kJurJQVHz1xaCwcTdDQY7Q7n2iFB/Y1BcM9iHTMnwLx/S
	1WKDeam9A/m4tHfqZWFAd5rptNigkQBYwhhyZlTETDCq+UvDBIUe7OnYP9wz+2VAQdKfL6Mkmjq
	ASOjNoXY0Gu4OLO2Va9Uo/yPiVL1vXQ/j4cigKYt1KbuuGXoB2r6AIqYsjVlSKTQgzhoywnx0K+
	uQ/ElSjWAvCWGKAO8DTxKRTwIGPVujwK5jAKx3UJVsLGA0o5iDZpsPnzEl3K62OByPCug4gPKsP
	Ng4MyfjX1DrA==
X-Received: by 2002:a05:7022:e03:b0:119:e569:fb91 with SMTP id a92af1059eb24-1244a6592d5mr11730336c88.0.1768873039305;
        Mon, 19 Jan 2026 17:37:19 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244af10e21sm18690198c88.16.2026.01.19.17.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 17:37:18 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
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
	Ze Huang <huangze@whut.edu.cn>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v3 1/3] dt-bindings: dma: snps,dw-axi-dmac: Add CV1800B compatible
Date: Tue, 20 Jan 2026 09:37:03 +0800
Message-ID: <20260120013706.436742-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120013706.436742-1-inochiama@gmail.com>
References: <20260120013706.436742-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA controller on CV1800B needs to use the DMA phandle args
as the channel number instead of hardware handshake number, so
add a new compatible for the DMA controller on CV1800B.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index a393a33c8908..0b5c8314e25e 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -20,6 +20,7 @@ properties:
     enum:
       - snps,axi-dma-1.01a
       - intel,kmb-axi-dma
+      - sophgo,cv1800b-axi-dma
       - starfive,jh7110-axi-dma
       - starfive,jh8100-axi-dma
 
-- 
2.52.0


