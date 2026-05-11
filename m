Return-Path: <dmaengine+bounces-10286-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFaVLn95AWqMagEAu9opvQ
	(envelope-from <dmaengine+bounces-10286-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 08:38:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C26E35089DA
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 08:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CBC53004D8D
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 06:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A46632E12E;
	Mon, 11 May 2026 06:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnnFc1pT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDFD3043D5
	for <dmaengine@vger.kernel.org>; Mon, 11 May 2026 06:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778481527; cv=none; b=h7x/TE5WplOblCxMT8w7raWrXS0mQA4l8qHYcLR6jhHH//E17IGcWgtcSdAFuSpjSizUoOW55h/IzM5RR8xFLA7g22NkVwWJDDsxJnz66I89azAb0mr/3vMpFtqtAwLoR+0316MLs9LgXYr4oL628Z+2HfZ6XFFliKc9FgTeOrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778481527; c=relaxed/simple;
	bh=rp9TUgqWsAEGx8ZoT9kL/TuCnQzCen5V/DE+nTxNcxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvvYqxCJuxqwD6tXvvmni/5Wgb8YqMGcsDC0346rMaPDgm2rteNSFA6p6PgO835QZtPzyYFIDHLTrP4CJHgyE7WuvUYeWcgliF7UUEsB0BriXFCCsIFJ1PP3CGYghxmRj5lUPSlqZtwM0bq0TqSHM1qa8UZBDMiAmp25PkKvpYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnnFc1pT; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36523acb0c1so2656996a91.0
        for <dmaengine@vger.kernel.org>; Sun, 10 May 2026 23:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778481525; x=1779086325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bU4crZfic9RXpArU6RhLb52aCOiXrQ2Y+zb7DPebOwE=;
        b=EnnFc1pTp6X+s5TrzyVgByNOdsVvAjfs/ryXTXnwR67MuBodCLJRLYehufJ0Q8cRbY
         YHO4BmqTjp0VbjWVZJe5blpbr3iDJnKxjeWAWOMFhnbGlkJdzQ4ch92VelT9hLyoYcvb
         IiypCMSO3WJ2+O+u98kAzTJY8ckfjpTIXVCaKckXA7Do1PUpAHYtvAHY6BAj9IzJNPGY
         h2DZLi0F6j6nZ6g8/m599GeBvr64Oo/kSTfgUIE+Xyl25w+A+aZqsTzqHe91oY7aG00K
         wn/wmWIOT7XE1bOVxsW9eq47Zom5XVGslUY6v5e3izCMljd92UEskAMmZ4cvpQpY31Mw
         he7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778481525; x=1779086325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bU4crZfic9RXpArU6RhLb52aCOiXrQ2Y+zb7DPebOwE=;
        b=WmVniVdzddDK7gmdYsv+Qwav2xMSL28TTcnAm/+tOzOSPS0rHKFIiYSRg1iuJWa+XP
         iaxt8IQnGe4opn3RwHtPXURhekK/05+wHbd0xQHR/01tFMvh/wBEOPdRJ0pKHX1FTvbG
         A09ypo3xF2fSj5VXddEEYCTnWpvbzyApa1b1ZrnDGHiX2wWcG9WyqzlXO2/RT2+zfKlh
         LvvfwPY5l1uFtSqXjjwzwCzs57eH/X8m2mNiuO9gRQjlcujurFX2ZHgOgudERiGkHetG
         2PczJ04x53Iq8b5KO7bPiiWOcxmACFYHbEJ8eEYscLVStN4iOPoBopuvttticomMgZoJ
         Q/RQ==
X-Gm-Message-State: AOJu0YxA+i8QXtwMaT5SPTziNsgI0jjCfv831eZln8v6MwPqL3zSuMiy
	iuhefHXiwsa9Goqm/oBchqYrP6/15LOz6UIs1FBRnqaH+l0fPl0K6XFB
X-Gm-Gg: Acq92OEtug32ubzJrovo2iBnhaMx9fBB/SAI0fPk20JF77swgm44gTuOpFviU7TUQeT
	rHXUMaUqaNMOkjdPiDbWkWgnLMTqdlRgwZvxc+pX/HEY6LpEBcwxYt5yDWFQYJCbLdlnKl/S29T
	VaJXKEC91gk8Hzb5khf/wXbxNR2UIi5J2kjzLT4btecCiHmQ4cn26i4qbTlp5SvK0R0bBkue88l
	21UFDi+5ha3rvAWLVCNt6NK/fFNWKrIEz6rwkLGRXzZum9fEVXrdcomg7WVrJd2u+GdxbGLGD7O
	sfBiFTCUahCMdTecrqc8PJn2+5wHShTmXc9LI/git9t9KOfVXTJvhJVTnghrFp1PfJ4FnD2fMF4
	s0ijpnlBkdOgLQmwaYv/+PqNBSj9NyCloeJ+WCUWoMj5zP04mzMFuU4iHkNURTvrTOHeuU7aw58
	tZbckDyeHzs9x8vzDOUbCfrM6ZfdMYIWRFFw==
X-Received: by 2002:a17:90a:2cc6:b0:365:fd4b:24ef with SMTP id 98e67ed59e1d1-365fd5a6b34mr13110423a91.8.1778481525495;
        Sun, 10 May 2026 23:38:45 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d687a2a8sm6358472a91.15.2026.05.10.23.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 23:38:45 -0700 (PDT)
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
	"Anton D. Stavinskii" <stavinsky@gmail.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v6 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add fallback compatible for CV1800B
Date: Mon, 11 May 2026 14:38:16 +0800
Message-ID: <20260511063818.463877-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511063818.463877-1-inochiama@gmail.com>
References: <20260511063818.463877-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C26E35089DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10286-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,outlook.com,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-0.985];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The previous version of the binding change only add compatible
string without adding the fallback compatible, this breaks
backward compatibility. Add the needed fallback compatible to
fix this.

Fixes: be3e2a0419c6 ("dt-bindings: dma: snps,dw-axi-dmac: Add CV1800B compatible")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 804514732dbe..0a30a455b0ee 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -21,11 +21,12 @@ properties:
       - enum:
           - snps,axi-dma-1.01a
           - intel,kmb-axi-dma
-          - sophgo,cv1800b-axi-dma
           - starfive,jh7110-axi-dma
           - starfive,jh8100-axi-dma
       - items:
-          - const: altr,agilex5-axi-dma
+          - enum:
+              - altr,agilex5-axi-dma
+              - sophgo,cv1800b-axi-dma
           - const: snps,axi-dma-1.01a
 
   reg:
-- 
2.54.0


