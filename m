Return-Path: <dmaengine+bounces-7612-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 117E4CBC175
	for <lists+dmaengine@lfdr.de>; Sun, 14 Dec 2025 23:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE5B83013E8F
	for <lists+dmaengine@lfdr.de>; Sun, 14 Dec 2025 22:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A4E2BDC0E;
	Sun, 14 Dec 2025 22:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YencAFIs"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35121F63D9
	for <dmaengine@vger.kernel.org>; Sun, 14 Dec 2025 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765752430; cv=none; b=Rc1TpMb1WOah3HlNa0e5BmJtDa9dCXqBdblSxwIz4A5imckt+BWAIvkOOpwtN3RNEjzOODJyZlyEP+g0KAuNj4iZs9nKYicKOKpVQmiPRu3U3OVpFAVzVAoxHg+7bGOfHL7wwkIDv4n8Xz3aVsKDAt9t431oQ/t/RBeNYguI6Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765752430; c=relaxed/simple;
	bh=6foIMWkM39YpRsrHkcMuBplG96nIcvxZ8pyBc0baPBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5wFNFNrCXgZQRr2jCoYaqLh7F18Ye2ecKWv7vWvAcfk0uT4M6fE5zqqcE+LwMV+6rbCML4gEVFt/5xbWFkaVwY+zf0g8x8AwClUiL0Joab9afq64TB5l4RdqjrJxDW0A8VDwCNZU73lrkDtJyrHzvxmaP5UZo6VFGDNKP8MBGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YencAFIs; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-bf5c7eb21eeso3005143a12.3
        for <dmaengine@vger.kernel.org>; Sun, 14 Dec 2025 14:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765752428; x=1766357228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2L35WsEaTxvf/DBI91MAjfu5hKJ1Z5i6X+ns/IiMxg=;
        b=YencAFIsGnGS5zTtewy16p5DuhGFIFERDNX3DurmGGBoBvSLCTQFDgTZ5W7VY0kvEU
         BUrxb/8brYXDDbdXwnfO8fYOy8ssnSc7Pkj12OAxlsyGOTpBVKfJ0mT+VXKpy42xZbG7
         DZfa8NU6kZLfcMLGmno54LsQL2abIYhRWPS6MxQBY7eoxA6vrEqPMsQdLaMHwOdhAWiA
         9njZj3EgzdZOt3OszOiuz+OJkPWlvGYIsxVK7JOZgWrzR0P7A8K2kx9F5z03YsPUsNxK
         4CEubxL4Yjo0rHMLrFp6A9xNJFL6NzoI2/eQSHNOGNI8RZX9tB1E5peA43OoBhes3cwM
         V52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765752428; x=1766357228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c2L35WsEaTxvf/DBI91MAjfu5hKJ1Z5i6X+ns/IiMxg=;
        b=QKyFBHjunbbOJloI85GbPrL7ynoTR52CKsGESAM+s8/5SStNYvJM2YrB3ygDfehGCc
         YgVF772T70vfaEcjyEAE5tFg1TxrDGvllygO3q9OV3b8pNBs0rwjx0k1H4zpIRhfI6Uh
         z6vAgilgr0QDQLrkO/AUX+lmLMwL3VOrId+AuuL1GT2eNJz6CoU/2aM+I1m0ZNv+QBLt
         cz0vMUT9XtM1rBoMTYtxriRITjwOgYm1vUv87qJF8/Ly1JZgy5vAKJU+UZ84Jwb5K84p
         uSvVPlMbyruOOAQYFYUU5ERgPyQToT68+i+HgbLrYfeGXee2Hy+0wi9iTX4LtlImrGuS
         TmqA==
X-Forwarded-Encrypted: i=1; AJvYcCWJH1T6myZhEmi4KWz58AMlOh5O6GYNK+TtCeeJ/r+swNx4S2yxVl1OqTwj7wriXijHK6hVEzjrzco=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYFqHZH1XfsAqCvQlRlzbMgAWZONoAroN1p9BpeQUBddJDGce6
	apyol000UJp2lnOqO9vSTwN8Nn3HpksFzNw6MJtoCiJ5sv1TjEt/r8K+
X-Gm-Gg: AY/fxX7TRmOqH/ZmIjWQR+qAqOP21T9gM9mdKd0+o4gI2ZmLlo5Yy8pYgP+IgLqTk5N
	QmpLMMMQqmdhWFtO6U5jfCMQNEQPr85+0UJ04zIIMJVp/u3nwFd7nTMeC7s+Cy27Eb7EiHOWxG3
	gKY6H2rJF8BX1b7MyxxsVmnx0wa6Vc6s9SJqbSP+KehMmvqNziVfqliiiwcLXzdyzRkO5Z2GMpw
	Vlqs8+10ccR7c2IsyIlRD5BYeh/tVLSMBcz1bJwN7u9IoGO++TvFdhE0q/AvdYm7kx7KJYpbHq0
	dYygxxWVDEX1UabOhV5LuTXnscTSyXLfeu6+zSsZ/UArG4LGWzWAY9wUScLE7vsmWYPJW9yMWyS
	8hifRLmbuXI1+mNfq++iQcMyjeXygqV7Fx0IsfptZ2ZrB8yMMVJHsm9iAym3BPuHB+CQNhP2l6H
	xGb9YbEG22fg==
X-Google-Smtp-Source: AGHT+IGzU40Bf02ZiunUmBQwqZQkwop4QCe+bNWbYKaguM5GeKAWWOUq5wkMBFK8h0HWejlWKzSlNA==
X-Received: by 2002:a05:693c:6014:b0:2a4:3592:cf64 with SMTP id 5a478bee46e88-2ac3018c2e3mr7575976eec.8.1765752427907;
        Sun, 14 Dec 2025 14:47:07 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ac191ba0fesm25394683eec.3.2025.12.14.14.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 14:47:07 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Longbin Li <looong.bin@gmail.com>,
	Ze Huang <huangze@whut.edu.cn>
Cc: "Anton D . Stavinskii" <stavinsky@gmail.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v2 1/3] dt-bindings: dma: snps,dw-axi-dmac: Add CV1800B compatible
Date: Mon, 15 Dec 2025 06:45:58 +0800
Message-ID: <20251214224601.598358-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251214224601.598358-1-inochiama@gmail.com>
References: <20251214224601.598358-1-inochiama@gmail.com>
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


