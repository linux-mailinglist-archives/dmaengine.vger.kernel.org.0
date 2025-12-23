Return-Path: <dmaengine+bounces-7924-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E9FCDA7F7
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 21:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1496E304D4CE
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 20:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D093E34F49D;
	Tue, 23 Dec 2025 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="JWd8YeUf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D2B274FDB
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521253; cv=none; b=tQdtAeSk74Z7guyDjQ8qpOhTpbI8C1hyVQdDO6wq2f5I0paut2hk8fdQ4jeG22F3nhi5ngDs5v4lbnz+cZ+KxPeNcPYnNdnB7hgKsh4/1SGcbCiMSxvGtFGjeBFt+47rsP9aACK2DxzU/4SLyGJsqrYobkRGvwy/l1xiKPcH1KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521253; c=relaxed/simple;
	bh=zUvrtsolEdengocgVlyXQxoSJXOg4mGPqcC0PLdIbPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixo+VI2xX9EXPGhms9C8qb5iv1MSEj9kJOYJVAqfafMHulSWzWVhusYPp5iC9k6wQxPVVp4oxdWE6gz6inqfsB5xDWw6SN56/HSHV130CHYy+Oc5i/HPPnm1+wC3jnUrYMk5q2cH4jlP7f4oa1WSR2OC8AIHhgLFgvbEucCjMnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=JWd8YeUf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so5735340b3a.1
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 12:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521251; x=1767126051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XldW6lxnsgyAezmPBHgoeGUpbHtzZudWE9rMzsQl4gQ=;
        b=JWd8YeUfcE2jxi4dlT6RjGrdeqZAThp66WLdnh1AdZbByRtMWbUC3/KQA3vOxoI7rQ
         Nej77PlWwyPaR0CweuAUAHdybLE+chQvK13KAx1PHCFCzP8dqOUX7DNszBLGLS3YPcje
         3obQGC21IXK8hIsdJaIVFWus/hPNRBL0nHrgv8Rk5tPmeAiEGaHpc8i+apiMSFebghNE
         0W0Qy8FfsEMkqnJOoL71GDcIZHE5UqsuPBST8EGPO7XAr1u45JqOy2YCVoY6QZ5iqEaC
         ghB9VRmSjvWVRdEspk9wiO4HaSDvwPHstMR28m2thH4fnj7e8ayv8KKHgpqopigvFmEG
         nQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521251; x=1767126051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XldW6lxnsgyAezmPBHgoeGUpbHtzZudWE9rMzsQl4gQ=;
        b=njNVZgFiWRRi2af1XxnU3dzmlV1d4vLKoLwUtzEYG9ObARFVmr1uL0dxE2l6tEFz1h
         6DN3ZEEZsEXsiQ4tp8MNPSWta4K2fLlHwleo/Tzj+B7IVy0V8pPl5BfzAyylA7FBXCOX
         sYpv+fMSE8B9k66JZIRupynY+jHSomJgFr6Y5Sg3o7igfjx54ZBDHatedbpoE7+sj1lP
         FyvOtytWUvrYThezTIaE210CikzInB+ZnjhX/wsP0eoggBufP+gL3utJYA9y7115SIQf
         oMCzkeX5TiestV/0w5s3bBzTr/8R4C0Ba9oUu6DlCpe0YrUf9LSn5Fh204SLjjrashCh
         pJ4w==
X-Forwarded-Encrypted: i=1; AJvYcCV1mHa/zlJuI/tZ3Jq3Ml6cfSuKDpjPOzCY3jSb82g7Bo6m5yNpjlwUVTiqYG0ZGVDhikBK6q7gQXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD45GyZpYGCgIKmK0fCGrtn1jjBi3qY9gDlYBzrixg5+reXsBW
	gssSt3DFT0d4V87xGmzWx6KneluHdsvrI4H2b13ZvlU4GTfiEn+xouVHQ0wRqaS9ZMk=
X-Gm-Gg: AY/fxX6StKpSsZoegbvuyX2r4fe5lWhBubLPNgCZYclcHbVVXmzM3TimrGNbmLz1RDA
	LrmLA1npFibMMnpJ1Hk8vT9Lprkp+eesM7BaVev4tOuKd9jtldLMdWlfwYEOnmRdsxljgKRZNt1
	m0xcxIJEhKMgnBsVjZjCfuA/1pdrvbaL6Gro4W07IKAU4SJpnqGjpF4K3+Z1otzu+ZMY7Wos2t7
	/SvrHaxWrOCaW+rEFvOPSMKimAPzSbj9Y56nUA9qBXb3/8njS+LG7cGP85HfqWu1nS0rYiV+TEB
	pR4HQQp1QS4HutO5OCzLw1mIaI4yacgTDM7TZ96qxz4juegJLXys3CThzXBixP2yjrME9AhI+eQ
	A/VbaJqeg+nRj9Zj9Qea6vK754ijTn+2cPOb/KCB2eGhY4W0qImzOiCv70Jlx2Q0yD5462h37VU
	3BZ2og6q/a3RVKVR//WnN540TAg5Bu2JY0Q4TEV+NZV39ZukLF869htPqPMxAMJwPkRQ1sxWAgx
	NmjwHTPgMZhG5oRA7A=
X-Google-Smtp-Source: AGHT+IHKR6G1JkjZPbcb6JKFu1uGkQq63m4FpssJS+cOb3Ug/zNWJVDVvih5redVT4o6Tq4IHHU3Qw==
X-Received: by 2002:a05:6a20:2588:b0:366:14af:9bbf with SMTP id adf61e73a8af0-376ab2e77c7mr15535010637.73.1766521251186;
        Tue, 23 Dec 2025 12:20:51 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:20:50 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	broonie@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 08/15] dt-bindings: crypto: atmel,at91sam9g46-aes: add microchip,lan9691-aes
Date: Tue, 23 Dec 2025 21:16:19 +0100
Message-ID: <20251223201921.1332786-9-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223201921.1332786-1-robert.marko@sartura.hr>
References: <20251223201921.1332786-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Microchip LAN969x AES compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

 .../devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
index 19010f90198a..f3b6af6baf15 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
@@ -16,6 +16,7 @@ properties:
       - const: atmel,at91sam9g46-aes
       - items:
           - enum:
+              - microchip,lan9691-aes
               - microchip,sam9x7-aes
               - microchip,sama7d65-aes
           - const: atmel,at91sam9g46-aes
-- 
2.52.0


