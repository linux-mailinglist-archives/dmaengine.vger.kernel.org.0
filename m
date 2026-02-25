Return-Path: <dmaengine+bounces-9062-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOUUEMnSnmnwXQQAu9opvQ
	(envelope-from <dmaengine+bounces-9062-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:45:29 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCFD195F6F
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A774230F3A99
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 10:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACA53939A2;
	Wed, 25 Feb 2026 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1UUpv0G"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379EE3939AD
	for <dmaengine@vger.kernel.org>; Wed, 25 Feb 2026 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016072; cv=none; b=K/CW5Oi2RqcI1r4Ck6V/e05m9uSrtX95YtOQVe5Jvl4tmwQKVX81eeyFm84s8EnkBxGLBiiv/gDae9mwgA08TbPtmk7U/gOQDLyxz+NE8ykuA9wzZlFHqOqH+PKxjxCwPBuYTYezFX5Fsd8DeWjO5OmxTp2gHrlBF/iWrhCQMRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016072; c=relaxed/simple;
	bh=yxOj5sToPmLzSh77Wy6Gl4G8jBqGXLhwxbTtGlE3Q7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRwgz+oucc/qLvrlJAEZSqXi1X6snU6ytW+R8Iz5C95veO2VUQEZ5zo8i49K034/GUEKG4lEMVR1vY+6wENYnO4OTqJv52YPaPg/ukKk++867arXPL+kMC8uHXuntWlXgMZyFpo310AUw0gt3WHH4YZUyk01oI8JHRIaqoHNHyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1UUpv0G; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad9f2ee29aso12320715ad.1
        for <dmaengine@vger.kernel.org>; Wed, 25 Feb 2026 02:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772016070; x=1772620870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5JusZ8CeTeNO4qDCoYo5++ntNew4s+UIqyoBHnZ8bM=;
        b=T1UUpv0GVZG1y5kPEbyxXdtfieB5PPFb5Ea4+OwObAEmboQGVjE05AHh6JgO2X+ar/
         czFeGlUKylvKG4R8amd9xOojJ3BqeIrsi7G4mgia/jhUUbIqtq6mmw30naZZYVtYprIG
         +88cg6BxKOFrtHTdsFFlzVlFm5QuvlVyfX2jHOfwpZ4QPKQNg2hWd2uE43eDxO7j6ijz
         egTxGjvGNmSddpB7gsmUc7HXVs/Fb8VX4C4inN9EetpYlBB4MLMAZbTyCpjWtT8PKrMb
         UUwgMpN5p22gptIftr6EH1PnpvgTyG7CJubo8rSRV4zvtx/e6wDCJMkGrbT5a4kkIcQH
         t25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772016070; x=1772620870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y5JusZ8CeTeNO4qDCoYo5++ntNew4s+UIqyoBHnZ8bM=;
        b=LrchJvj4gPX2ifItSo29osvijkCrkwv40sygbq6/02vd4L+deZntR7DejXcEhTBCJB
         ZyxaxY/PYInnmNDDxAsbITcyxMh3VsTdxHdslV4kZzj5GgaTUKz+gDiPKkkL8+pEOKni
         bhl0UZJzXSvcrknzcb7ipoVk4LoVVCUnAJk4O1Y3cx0DGXcEGzu8tUTFve6I+x7SOqom
         G6tIPvbrUuXemFkQHRGqW1ThEdHewKRV5RB8TVgShrJUqWng0KTThBfTwcx3MVfFoXpg
         g3bv9pae2j3qPhG1J56n9kGO8YoYCu2WmtqxCSvEBXAX8l93yHBJKUDvJku+xiYS594S
         cbyg==
X-Gm-Message-State: AOJu0YwYnRhK7fOLxAVMOuzjZkJUdAw5tjtZG9GM62krvQjrgGrt0x+x
	64/fDkDivFBBVe6Wh/l86z8QwdWJ/Ft7QSNw8pNhjdIDzuiolSSNwsBl
X-Gm-Gg: ATEYQzzvWMluI+pfw/uF99+ANJDNOAq1EVJQ5goj3P5YHjJU5YG9X3hA2KroIjSDdvB
	MDb6nP1TbLfiOtvDsH3Fs4nB691ivqbybsd9mVizM44/4CFENFNEgsW6sQAVod2oPdQ+Jc/4nAq
	Ol4j3JB0837rH7BmL04Ovg32IQ7++4nReM06BM+JBoSOlE6EZgnKkzxRKt1SurZlVJRCM5QlD/8
	84fAz3DjSHiUXUivYFnqoANY3lqC5diigE1rSwtNULszock+6tw7DE2WR27pyJ1cTUhz2tGnfyN
	RTEUFhAFY2ogyIVBpejnc7epR6T9EyE3+mxVQKx+foh580IJ2q16m8DpY8OewCnsLVdZjPX6JdY
	nEGssa9XLyAGSlVcesNlpXwe6YMTRR70Xp1YZve7CufxxxiQAQZPB/7j6hPaSvjlW4EMtFs9FMG
	aaWejRQ9iO3mvZ8Vha0J95u2qmS2FjYCPI
X-Received: by 2002:a17:902:e787:b0:29e:9407:a8cb with SMTP id d9443c01a7336-2ad74548a87mr147819225ad.40.1772016070549;
        Wed, 25 Feb 2026 02:41:10 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adb1bd6b05sm41625085ad.79.2026.02.25.02.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:41:10 -0800 (PST)
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
	Yixun Lan <dlan@kernel.org>,
	Ze Huang <huangze@whut.edu.cn>,
	"Anton D. Stavinskii" <stavinsky@gmail.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/3] dt-bindings: dma: snps,dw-axi-dmac: Add CV1800B compatible
Date: Wed, 25 Feb 2026 18:40:39 +0800
Message-ID: <20260225104042.1138901-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225104042.1138901-1-inochiama@gmail.com>
References: <20260225104042.1138901-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9062-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,outlook.com,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,whut.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FCFD195F6F
X-Rspamd-Action: no action

The DMA controller on CV1800B needs to use the DMA phandle args
as the channel number instead of hardware handshake number, so
add a new compatible for the DMA controller on CV1800B.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 216cda21c538..96b0233d9b1b 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -21,6 +21,7 @@ properties:
       - enum:
           - snps,axi-dma-1.01a
           - intel,kmb-axi-dma
+          - sophgo,cv1800b-axi-dma
           - starfive,jh7110-axi-dma
           - starfive,jh8100-axi-dma
       - items:
-- 
2.53.0


