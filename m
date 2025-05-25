Return-Path: <dmaengine+bounces-5265-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A45AC367E
	for <lists+dmaengine@lfdr.de>; Sun, 25 May 2025 21:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67CD3B4E37
	for <lists+dmaengine@lfdr.de>; Sun, 25 May 2025 19:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA3E25F784;
	Sun, 25 May 2025 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AZPkJZ5C"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9185425F975
	for <dmaengine@vger.kernel.org>; Sun, 25 May 2025 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748201178; cv=none; b=lVnvAW78ikEKJ/Tqq0PnBmxLTtS02Ya10JLKppieAcab+IPjAvL+XRECG0XrE+1BYMYJtFXtG6hX1deqhXG5tepdCaGgQ68I40qMa/fWju5A2m5eD5nWLCuF6fY+gwmr8CHORorU+i2zd7IIiWyaSSKPNOR/312FsK+1Z93DMEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748201178; c=relaxed/simple;
	bh=DTGCxtKKBS1I1ezcV34L8Qi5iTSOukUz7ljm7yYIh1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WbjF1/Q7DoiK0IYo/atoXUchcLp0tXfPUOBzTYcnMS8lOCrnC1Mo4gyM9kjEdV4fJ2Huc7SIB5biiYC7ihqPj9FAzanR9WZ09tYoFIqwPcFhCUNBvkPkIDk975OWqUo79F0Iizf2I/Apo4gjL9kzU8xY/4S6qrK3+iL7aMA52c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AZPkJZ5C; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad5735755c8so31665566b.0
        for <dmaengine@vger.kernel.org>; Sun, 25 May 2025 12:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748201175; x=1748805975; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUGmk08kPRJlfJsZZ8kitsMWnHXcUPNuZWI1jkR5sn4=;
        b=AZPkJZ5CcG2rmSD8B/UU97AK50+PYHBhkK+s4fCzOWdsBtEwpEClyjgHWDyUJVUh/i
         AQf4Mi4A6GVtlhz+V26vTd3RGSaDpO5g/uN8LkqGpHM8X+nLFYutuuU2KmtN0g3SamZz
         eqKYRpCApR6LpEE9s4QNwb4Ja+DLOYsd9eLn2tIhvk91uvHr23o5rAJnbtovYq95KXmV
         fK1vk1zcRDEXe9P9UzxQTh7x/AwvbQRV76krQeMet1TtZCG6/H9XTUzL8785ieOX+gbz
         h8GAzEFxILxz1//eKdcsnXtZBXfDYKBhmdycJmyOOetqcWAbIqTZEWIWZ2aI25R8Ag2m
         XLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748201175; x=1748805975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUGmk08kPRJlfJsZZ8kitsMWnHXcUPNuZWI1jkR5sn4=;
        b=tNvcDrEkpFOU9zfgWdGckBRrTJvG6ZbaV1ef7O1vz/CKMUPdTkBWkxL0Y6IK+2lCh4
         9EDt3ne4VnGGaUhSl9UBTx5W497fhQEWdSQqiOAEIbtMr1KqHCxCs5iE3RZZe4mOBPD4
         Oq6gEKAvP9L4knfrY63j32vrmgRDzHsehnHwqdT1zQxJ+mX4Io0iENOIaJs2zVvEvMjV
         SvxqBfjIYEJlso6ibgWEvIDGGnlqC0B0Zxi5dviIfO0iE7Y5ZdAgRMjwH5qSW8Nq9IBi
         fQTu8v3YdJ4OkCg9O8rirSok7ebfd6Wn7TP2qCDOK5bx4og5p8Cuk7Gx959Kv9ojSOLK
         OWZw==
X-Gm-Message-State: AOJu0Yy3to2EUKjEtlsW376RDUVZ0qrLyR25yZiZfEah9gYnLvWX43I1
	45UBcWyCyvsI7VoXDf+zJ4Cm359g5c+lxG0rE9/7X9aolz1ROo99p4Cdbt7ronku9ig=
X-Gm-Gg: ASbGncvd/sYdBiHPLrciBmV6l2bdfW5kx5VK0MgBPVJtwnPdm3ANtxo7ENz2IN0BfZr
	JeJMGyxoym2o0i8NbEGaPdQRDM2r/xhZM4L0M5KHrVNuF0vLtfmJkU7/wdLl4DgfQT3ac7yZtDU
	AB2dISJRueNB+M3nJcIgVXpIkxbaaZ6FrD3gkCDd8M1sWD6qUXj5WaeOPHQ+oE78dbAkm/0foZG
	fLKV8wty6K24f3SeQdytmFoxyFUO2ccsSeNey1l/tp0oxIUiP8n/giGJNdCW0Xp2l/BSwqmc/qM
	L4437dAMi+eGTs/nfuXh5QOA031VxtXGqaINgMC3cGLdnhXaraPOD4VSipMZcGQIlAuiUPE=
X-Google-Smtp-Source: AGHT+IGDspk3xRlZUcMOomJg+MJ6Cv8DfQb08HEeWxoIWLa0flvIj8xNaDHLS9Dogctf47fotRXlMg==
X-Received: by 2002:a17:907:270d:b0:acb:1d24:a9e0 with SMTP id a640c23a62f3a-ad85b1e6fbdmr170962466b.11.1748201174891;
        Sun, 25 May 2025 12:26:14 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d047738sm1578899866b.19.2025.05.25.12.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 12:26:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 25 May 2025 21:26:03 +0200
Subject: [PATCH 3/5] dmaengine: qcom: gpi: Drop unused
 gpi_write_reg_field()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250525-dma-fixes-v1-3-89d06dac9bcb@linaro.org>
References: <20250525-dma-fixes-v1-0-89d06dac9bcb@linaro.org>
In-Reply-To: <20250525-dma-fixes-v1-0-89d06dac9bcb@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=DTGCxtKKBS1I1ezcV34L8Qi5iTSOukUz7ljm7yYIh1c=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoM27PgAKcZyUOvAe2Df5AqRmgIVPRCSQsc065v
 J0vXKIuBY+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaDNuzwAKCRDBN2bmhouD
 1/nYD/93SvlxVjCD1TglYASkqQ2qqr000Y89tUkwwl2SoG+YN6656cSxwO1ACez/CVB+6yR6bxt
 ga+T22HudMKUyp92eidyz10KGRV8qWPl6yv/DpSdOBtd/+3OAjhxX2QBRgeEWuJmSNlq9lSq0z7
 pa1ZX3JqZvoUP/pt+VnLuQed/qp0whCyPJ7KyYbnDYM8SC8mc1QBpoi8m63t6rY3kKEw1svY5U+
 Dua5jFWk76pkInqHzO5li6TwER5w0iCu7qcgOFKYGU4FGppxbjiIMk7zHWjXlQPinlpu4g6SiMX
 fQLfs+uluS5rS0jol1VEPfaOCG5h1GO2lXs1LDmajFgs1tgHQAT4C1Sm1U7s7akP6oZiAUH3dlW
 +FFGMF2udbtXJtzaqiQiBtGCPsE2iNBBE9V5oHZFMGrmSBBbO3Wlp8dHSEN4qaZzufboPLAUKu+
 1CsRChawkry5babwEB60I5B4IwOXlskk8nP90OH3501BliTpnHfXaXQTJw7G9hmdlujsfUvSfky
 s9vTTuN2cag/K/saGkyswv/H5SegkF+RUQSKHg9zJdTTNqG9Q4NQUzmy7AM1pIdNJJE6kFdM6tu
 fbIfAm9Ip/NenXmCFi+sKeWGwr0C9kJvCFC/GQRI9Q+RArWGPnNrUl2CLN6eHZRQAQHuTLQupG+
 1JAA+eGmozRwJFg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Static function gpi_write_reg_field() is not used, W=1 build:

  gpi.c:573:20: error: unused function 'gpi_write_reg_field' [-Werror,-Wunused-function]

Fixes: 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/dma/qcom/gpi.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index b1f0001cc99c7066b6d08f53d9381d4fd22588ca..8e87738086b25ac37edbdcd5e237447f3e832e8e 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -569,17 +569,6 @@ static inline void gpi_write_reg(struct gpii *gpii, void __iomem *addr, u32 val)
 	writel_relaxed(val, addr);
 }
 
-/* gpi_write_reg_field - write to specific bit field */
-static inline void gpi_write_reg_field(struct gpii *gpii, void __iomem *addr,
-				       u32 mask, u32 shift, u32 val)
-{
-	u32 tmp = gpi_read_reg(gpii, addr);
-
-	tmp &= ~mask;
-	val = tmp | ((val << shift) & mask);
-	gpi_write_reg(gpii, addr, val);
-}
-
 static __always_inline void
 gpi_update_reg(struct gpii *gpii, u32 offset, u32 mask, u32 val)
 {

-- 
2.45.2


