Return-Path: <dmaengine+bounces-7925-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63096CDA893
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 21:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BE8330A1606
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 20:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ECF352F84;
	Tue, 23 Dec 2025 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="qEXm32uj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8737B352941
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521262; cv=none; b=V3dpnm56whUqDwud6Sy/7PHux2Lsnk3jNqIcPRCZ3P2uWOUtkgl3/L0o9ZGxygv6ax8NDqufysG0fSmoT4s8D0MK+Uyr/q1MZ4xvrOCdwZGCGNnoz9Bsfv+8cSyocpJOXI6ydTgtOCVq32LI0LCrktrejXSiW6GVaOItL2aqhDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521262; c=relaxed/simple;
	bh=7hKH5EzmH1tw2QTQXNXPEJl0sVHK/le/PcpUxmqe6fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OeWil4jPzHk+npTTpr+f5OiFPznIvaim8zLF8u4Mwpim6KCv64x2+PC4Mp9Q4ALZ+nB72cW/5xJp3YBP9bKDKiTZCiBqRAiEDV3PzhiHI3pkoffHJ1kNEMDD4qE9Pey9Hf34gcbENLkHEJEODlFXo0X8WU0ZZhzdyoz3galCcdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=qEXm32uj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso5382958b3a.3
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 12:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521260; x=1767126060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MElNA+evLW3q9gh9PLqoqAuYhUoiUgxuy1qDVWGw3Ao=;
        b=qEXm32uj1+odh+mia+XgDAG39bxsV8BBnWSP0gbyH5RJhUfEzyjInuhiC1FtX9Wppx
         KLxk0YDYruP0rpIpgefdNHqLi8+C65Db06vxmizhWFJNlUeyE4PALzO+idf0NA0jEvMt
         4bfGeG4K9boAoeBljyhuYdHQPXx1fzDNbBeLm+/ymuEu2mywxvu0nFbFozqKna0aW5o9
         UF/l+z+RE/wWwKcEoAMBfnOLbiRWzz5O8Ua1eIoWr08agzCuSQBanUqTE3b4fvbRKl4J
         RwJDjpDIeBb/IhuLWShFAWC3/IHBkQBxlolO5/7LijryExtWwxx8zreGCz/caCv02scj
         QTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521260; x=1767126060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MElNA+evLW3q9gh9PLqoqAuYhUoiUgxuy1qDVWGw3Ao=;
        b=Gm8rOZRSu2AOvUGbZqeASSaJBdy+2mg5rqa4PMIqdqPOttYBsmrvrrtQG7dBvvCpgo
         7eEsJuRwOum+QGQNV6Paqi+Zu1qSXSaljsO4vqWU4KoEUHYDhehj1HKwuXZRsv/jWNru
         8xVU30r+GWuhjtCdiXRFjq5xaAy6XFgx6/EDYBtYGQZxMGr7OMCdXgxpWqnU+r50sLQV
         UPfs/u/ozw1OJ33mcdltoS10BRP8xySBtMNTyN0tRhU9rNeoCvyPw4pFfP4W9mlvJY9J
         nsJeV73ie/BN2Y+485aLuisyGGf0e7ttl7oJfznwV8rFXNLzmfqtA38urWFTrp/oh41m
         EIbw==
X-Forwarded-Encrypted: i=1; AJvYcCUZvW45ZR0WmZPO4VZWiyQEYNgCM3zJeZ/LkhZlKD4rFGs7KEnAQAmUc96RiN6KAa5y07AxZKOnm3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydg+y+mvviC/FhPXab2IsYJ9XicFsEQ+LqNuZYgmiczoV1U3cM
	+y8ayTC0y3vartB3U5LJYc9QO362s5Pjf0Bd7DZXPLINaqjIzzONfvI1q2PAShj49uc=
X-Gm-Gg: AY/fxX50yrn83qfv9dEu/LiFa0jVtks8g84oRuidmELtbCFuRykf92O+37AyY7icn7m
	GMCDUh28sDurk+USQf/bKduxHSKDtboTPp5dyf6gUjnzZklQlLwOfWEgf00mEJ+LTnS2Mu6jBH2
	ajXRCWbvniCj0jNJFiG/oKS+HndI3zQ/b7P8zjPPCNm4HqQHLfPZ+MSnCjNdBZwm2G/pHo5GLGd
	Rnh37oZZcRO+P+d3NwhZPQtaCgIWqZpOep9h1xJmU0NhbqRAD+AQh3a7U3+sWQt60L5K8vVWlDU
	HmTENHZuKAYFMDZh8KDV/1zAYXHWYCTDh649FguoKdRWZFtyDOwf3eXTKInfzs0sETBcbke4GSf
	E3vYJp7r+pzP+YhgkJHQVjnQ8OkE4tltLWoVCFEAizs8p9ZuGZvwkp03RmmoH06hQYtrnLKzbKK
	Lql/Vpp3hMqxjTRtf8yRXdni4Y4rIEXr+O0GEY1e3R6mqMFmXA6I1W/qSQEGrA2Cipp6sqW2J4N
	5O6eCei
X-Google-Smtp-Source: AGHT+IHKfwHDjFbBjFoOP1ZNZG2yYIy8Xdi86MslAqVbrnS76U8emwCJO7CURd8duOcxnItzlu++Ng==
X-Received: by 2002:a05:6a20:7289:b0:366:1880:7e06 with SMTP id adf61e73a8af0-376a5449622mr15082294637.0.1766521260025;
        Tue, 23 Dec 2025 12:21:00 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:20:59 -0800 (PST)
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
Subject: [PATCH v3 09/15] dt-bindings: crypto: atmel,at91sam9g46-sha: add microchip,lan9691-sha
Date: Tue, 23 Dec 2025 21:16:20 +0100
Message-ID: <20251223201921.1332786-10-robert.marko@sartura.hr>
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

Document Microchip LAN969x SHA compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

 .../devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
index 39e076b275b3..16704ff0dd7f 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
@@ -16,6 +16,7 @@ properties:
       - const: atmel,at91sam9g46-sha
       - items:
           - enum:
+              - microchip,lan9691-sha
               - microchip,sam9x7-sha
               - microchip,sama7d65-sha
           - const: atmel,at91sam9g46-sha
-- 
2.52.0


