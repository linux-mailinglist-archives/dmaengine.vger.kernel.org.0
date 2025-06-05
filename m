Return-Path: <dmaengine+bounces-5305-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46138ACEB47
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jun 2025 09:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBD6189A1FA
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jun 2025 07:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FEC1FCFFB;
	Thu,  5 Jun 2025 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwskwrsW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34921202C40;
	Thu,  5 Jun 2025 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749110132; cv=none; b=Xe8JxhgkhVf6K/dT800C/+tPz6sz3IDlnxvVn2tjbyWoqr5ser9GM+W1lcup9OL98DK9LRCc1rOOZK+0TvnuxtEsfQkd/2gGLb6mXAHPKD6NblXLTbINnkOa3P1EM0I6k9Z+T2AWuUM7/6x96iXjDcaVIGFhnBbLbi3MS88qBn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749110132; c=relaxed/simple;
	bh=R6cDWrNLeIJW3a1+hrWpOXzcEBadxi2F3alk6u15b7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5PgukDAngM12mFL9ccI5ZRdJg3Vx04OeQszfMkiGJVaNEtvLiyRPnsh4fGGBpyGTfcuNW5CMcfLIHMIjIN9FxJYqlnjkCY+F11rSkgeZsf09/EJmCWw81PGxh5HAetdIaqVd7u606elvj6sfYHgtA6Ol1HXzccDPwO1P61+ktE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwskwrsW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235ef62066eso9340035ad.3;
        Thu, 05 Jun 2025 00:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749110130; x=1749714930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OARrN9ueY6P2vrwU+QQZWWr2aQNmcjiO53DZHt44K8=;
        b=FwskwrsWFclBWLDTUlo95Hd2DdYfLapx5rZou0M08/1JPt590PBPR7Oscx6MsYY2CE
         +11oV3YbTme+NeNLM4p27Q4XnOu1zcvzvhAciFd7q1hcDnhZUK+42c0FrwAMY+8Zptso
         v2fs6OaC2J81Zu/VAY43WQQtU8im33DHsdTOMEbnFr94GMI0iYrqdjRm0loL5fKQiIWd
         xbAY5t6OtZDfwzt0T5kEboBWYW3qcIdQIylkPgxVzAVGCCDmXpfxzjI5MeLTEE6q9dtr
         D+ZSok738JaN/tk0RPd2fTbCV5MN6UkgFvnj71+3wM4srZKef2rtqKbZmnb/4f939l3U
         u2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749110130; x=1749714930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OARrN9ueY6P2vrwU+QQZWWr2aQNmcjiO53DZHt44K8=;
        b=I88j9KCcLl2LK64uT6/l7TQiOyQP9Pxyts4EXo2qEylT1VPUTNEnBn2hxTm/sU0MY5
         DChG2pgBEI1UOm8OyS3DiYZ5lWTAXzGoCyaZEYOu74L71irqv2CRbJ++/TWnHQjlg3FX
         GTTZ3frYULJY0MCaSiv5eTFDk7y2U7cg4+IH0Xf6KP2w1jUE/rY0ioan98Y1xH+D5sbo
         ZdU5DpFLvJp/6bgfU7Rnzoid0bB2t3DBrOhBm5JLpugwZrtLcGUGYfgdMXMpZd9xg6qt
         KG90dkK7SUi57lzfaBBmJwZKI63f8xdiwV5KAmMmDSmFsEcE+PqSs0gsl5J3d6XU0EbS
         fxsw==
X-Forwarded-Encrypted: i=1; AJvYcCUA4vSEWQrU5rnsnrTtJeXNZ5EwspKNPmEq1VLknp/tUZGzU3nZlzUveM6a861fOPFUN+UaW7P2SvOzkVYD@vger.kernel.org, AJvYcCVSHKj3yvxBl2sASXAx0BlH0AoWHvKDxmZe4CuP5Jem1T34OJNQ5qEdJK8HJHCJi2k6JJFgSXKjNGz3@vger.kernel.org, AJvYcCWnNyOZJ0sU5B3RkW2zwH6oamjxqlayPgYpBXhGUWAC4szWHRF6kWJjDqNrkCLoBdvPwrN8KiXKGD/k@vger.kernel.org
X-Gm-Message-State: AOJu0YzG57LuCOS3g7Mp/wDxFjDfZzgvrMOPe+q+g52D0CaMLa4o3Lns
	p6ni8//v1cLY3zONpiFZrc+pY80tb7fXpHNqjo8ab8T+zqsW9T06qQ/z
X-Gm-Gg: ASbGncvJkvu571tVFnoxfskq1Gkz4LnWGMtDkhYX4iI/H9OJ+fPjiVcd9BF37fbIXjW
	27Dv9OPSMZYrSvIk92zTeC9YqmNJnFXmmQEQnbgyjE2qBQRAXYDNtNpD8rBevFIIrwebrh+Xcfm
	xP8RtijnNGMXrRq+0Gt5ISIofj9Xkh1LnGO86d+NtPSlxDmMZLEWNcIpjYgB3391om4Q4zfOxLl
	sbWYVfBhPgUAc6YCefsvNwYBkGdDwFTvh3HhV+5yOq7S3xBdAlFMmUQLKCf/78PYCfuriVaJhyu
	+BklpjSIZtenz8SR9cRlwAFwDPn7F6qzNcnwc43hFvshQN+LVQ==
X-Google-Smtp-Source: AGHT+IESM+PsIHMZjhlFraZNSrVLcXeSjWVnZVNlOFs0AbkPjyTu6TKzdg08IR+ohI1U6CzkfeXnig==
X-Received: by 2002:a17:902:ce82:b0:224:24d3:6103 with SMTP id d9443c01a7336-235e12535e8mr99006335ad.35.1749110130339;
        Thu, 05 Jun 2025 00:55:30 -0700 (PDT)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc86cdsm115201015ad.8.2025.06.05.00.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 00:55:29 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@foundries.io>
Cc: linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH RESEND 1/3] dt-bindings: dma: qcom,gpi: Document the sc8280xp GPI DMA engine
Date: Thu,  5 Jun 2025 15:54:32 +0800
Message-ID: <20250605075434.412580-2-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605075434.412580-1-mitltlatltl@gmail.com>
References: <20250605075434.412580-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the GPI DMA engine on the sc8280xp platform.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 7052468b1..19764452d 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -30,6 +30,7 @@ properties:
               - qcom,sa8775p-gpi-dma
               - qcom,sar2130p-gpi-dma
               - qcom,sc7280-gpi-dma
+              - qcom,sc8280xp-gpi-dma
               - qcom,sdx75-gpi-dma
               - qcom,sm6115-gpi-dma
               - qcom,sm6375-gpi-dma
-- 
2.49.0


