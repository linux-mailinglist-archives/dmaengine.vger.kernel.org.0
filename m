Return-Path: <dmaengine+bounces-4643-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE31A4E537
	for <lists+dmaengine@lfdr.de>; Tue,  4 Mar 2025 17:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8B04230FC
	for <lists+dmaengine@lfdr.de>; Tue,  4 Mar 2025 16:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F7324EA93;
	Tue,  4 Mar 2025 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgG13HQC"
X-Original-To: dmaengine@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF9920967C
	for <dmaengine@vger.kernel.org>; Tue,  4 Mar 2025 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103280; cv=fail; b=G5TNkEjIKGOuFHJZcoy5dkDTs1C/UIu2w/zKMjQu4PDRZmaYRrz0WRj10IVsJiK39YRD9CdXEsCm4m+OrFxwVDbJAqiCw918DER5wO/GOz7knh++4TlEVirIvZJSpUAGU5fo9DOWqJCsbXisV3ijlVK5awS+Difo5EB+I70IoC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103280; c=relaxed/simple;
	bh=rzUyQYrmm6WCZfOwaxIbcCxCIxCM2u4PQR+rJUmwZtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rYfy9YrFG6kSDIam8dgQfKZgUKgPfNQSvYgp0ZXNVav3mvYAF1+g5VBenpn4CQr6x96U7SGO4XrPUFY/3LosXD3rqsLiHIMO1yvujIDadOMKVN2f7jWQpyiZZNKRaO2RossRt/yPGZKLdbsps8captZzRiL2leowWYZpbCYiA7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgG13HQC reason="signature verification failed"; arc=none smtp.client-ip=209.85.222.181; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 06B0D408B64B
	for <dmaengine@vger.kernel.org>; Tue,  4 Mar 2025 18:47:57 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AgG13HQC
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g5071KLzG1GJ
	for <dmaengine@vger.kernel.org>; Tue,  4 Mar 2025 18:45:56 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 3AFD242724; Tue,  4 Mar 2025 18:45:44 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgG13HQC
X-Envelope-From: <linux-kernel+bounces-541070-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgG13HQC
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 90F6E41A7F
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:58:13 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 346CD2DCE0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:58:13 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB4F3ABEB0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 06:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A1C1E98F2;
	Mon,  3 Mar 2025 06:57:23 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5763B156237;
	Mon,  3 Mar 2025 06:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740985040; cv=none; b=fU0hnrsejOHlquAasBpnKVXyVWh7UIDavvcW9wtJL7zz5r3y7irLWGWqHmJpmWAAYztiqZVIyQRwF5FI2t7NcI0bGRiwe0zpT+mfFJyTXuqKRV0LnJzhm0sjYDG8uV8bY7noqTi0nGOpWXgh7S3DKlQU9s2GQJV/168r1MnsL/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740985040; c=relaxed/simple;
	bh=28Vxb9MlXzLgsQOz839ouf1ZOb6pV/zDw7qLv1Gk4Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nhHPyUsmyq7fGalwwYzBxH1/wp/i4YT15DVRr1tmj7dKQGKOLRfstznmaYXcDKkrJfMP+Yw3MeNSDqeCdLvyFoUuHx4/dwJXnntZtryPgJQjrq6xFx0dHipw4IxqIg6RqZK6+wR3P1iuHabrp8qkbOyHl/Vb7n8wprhNOH/tdIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgG13HQC; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c0a159ded2so323373185a.0;
        Sun, 02 Mar 2025 22:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740985038; x=1741589838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dXZfifyJPh8wTQJHpr1hJkVkOZWigbIijHigtJZZIQY=;
        b=AgG13HQC0jrPT4PRhvB22LG94PhT0Uhe4doWnPx+ID1PsF3L37ck05bxDl7MBXhelN
         +sx6hojZvnNCWn9LyRqcObQSbh+0o6fjI5eWshPUYhNwtRiloSNfcfvrG//NWbSI18G1
         LPqUCoBnzySZpOcrUkdk3CbJlHk8MogOG27RpHRJPYGhfWy4rpPdoc+hAaCiSSQNencs
         XQOoXKs8+RGvQ6HBnO/fhcwBoCXqKBXIQsuFO/2CcaCMG7/eUhDvBZR0gw4j/3RpqGWF
         HLSX0P55RrKKeJLggCaLDTGE6b2bvf9Ns9kEfiIoVQTPRs3K/gRa1r6Cvnqm6Lqff8C6
         iOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740985038; x=1741589838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXZfifyJPh8wTQJHpr1hJkVkOZWigbIijHigtJZZIQY=;
        b=KihaSo/1XvGM9ufFHUrrE2SqNdC8BVNuwOKfRDiUvOqygflImnpD4u0LMxUjAJtXph
         XkMSt8VGml9ypxrZS3fgujtDZqB/vc+odGlU47wvtdlmhDtzuAkOgeEN5NRknS5gz3Nt
         6iyaba17oNeF1v4vUK39n8IkNbyzPbkvuAEELhf1Mrf/QIan98Yktlm0wiRf0YnJVqYh
         bOQTwf7WUSfRh4d/oD1bDLe0lEizmRvwVAoeXdCedzZ6X/t5Sx+xeq4yizwbgZr70tJK
         fONbzBLVO2aNybrD5fh0T7OMvwyBWZ2j2FgznwD4jW7gEDbu6qcgkKhJbjaGyv4l5taZ
         MTaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkj7zQcq07qDLqopG3i/WUQAS18RCgWaVR6mjjkVLe7kOO32/BBBbIgKSsvz5VZSuHRA4F184PYTYi/Z7e@vger.kernel.org, AJvYcCVnmEsslT2yEpbBXzvcd7iTNemOLK0cshv/R1bk0b9vj9XWrcLBqdpgQKTOTwahLR6Ce3vK5n82VXJS@vger.kernel.org, AJvYcCXh30+ZnJcHY+LTP7t76c+QieiaFonhm4NHdm5rY6PFe5x6qMs/XCeeCm/t9/Pi6ZstSmzBWORF0MOQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyMRuOfqk9TNagClQpe9uBbwjusDAbAvbPOJSo9uva9JSuizgrM
	YQvQlY6FpsnO4FdOQTMgjBOtkJJG6LzuWx7vbd2O7h+3RNBQLcAa
X-Gm-Gg: ASbGncvf5ZlnHDw5npBTJc00Ac9JJU6wMOBhoBQm2nHEgoYBm8U6bnMmkICXrLOq8fj
	jWoT2TfsFb89ekvp8zgEhUQsNDvSRhHdW1I9gTtn3jdLT/3VE+o7qUS5dlG6iRoQmBeMNhE4EtN
	tzhXXv+TEGU5zjcqS+Ga6+xoFjAynY35I4W1Ejwf++yHGkXRrGE1lvoEqqJe/wVNsL0IdQxSbgs
	9HsJOZ6OVgUMMHlVpbNd/G5wGHxF6MPjsrF1Qx4S8ZESUbniupoh/rR+673y9EMQWkZnKrJu/0h
	Zgrwg3N5scqp1vlUZxHl
X-Google-Smtp-Source: AGHT+IErdmW0jjNNNMzApy6HTTPEzszrqwNuoD6aXiczUEO8+rrdFm3G8YBCKzFZYWry8xg0LYIFVA==
X-Received: by 2002:a05:620a:4392:b0:7c3:c1b4:c8f5 with SMTP id af79cd13be357-7c3c1b4cd30mr159420085a.15.1740985038075;
        Sun, 02 Mar 2025 22:57:18 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3c57684dasm17000885a.77.2025.03.02.22.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 22:57:17 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH] dt-bindings: dma: snps,dw-axi-dmac: Allow devices to be marked as noncoherent
Date: Mon,  3 Mar 2025 14:56:48 +0800
Message-ID: <20250303065649.937233-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g5071KLzG1GJ
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741707970.09477@wXMBF4dXbTIrOIbtc9VQBg
X-ITU-MailScanner-SpamCheck: not spam

A RISC-V platform can have both DMA coherent/noncoherent devices.
Since the RISC-V architecture is marked coherent, devices should
be marked as noncoherent when coherent devices exist.

Add dma-noncoherent property for snps,dw-axi-dmac device. It will
be used on SG2044, and it has other coherent devices.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
Related discussion for this property.

https://lore.kernel.org/all/20250221013758.370936-1-inochiama@gmail.com/
---
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml =
b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 525f5f3932f5..935735a59afd 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -59,6 +59,8 @@ properties:
     minimum: 1
     maximum: 8

+  dma-noncoherent: true
+
   resets:
     minItems: 1
     maxItems: 2
--
2.48.1



