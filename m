Return-Path: <dmaengine+bounces-3408-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4289C9AB566
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 19:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26BE1F22DC4
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 17:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C790D1C2452;
	Tue, 22 Oct 2024 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TMZdZq7/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603BA1C2431
	for <dmaengine@vger.kernel.org>; Tue, 22 Oct 2024 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729619230; cv=none; b=exAx9bigKp3vbzAuvzRVeW+wocSUm6HVHUkgrALk2TBz+NQq4z7F1vizVq5mqsS18HZ0rbOst/N+e5n6rVYVlSCcNa21LN9DZzLf/ZX44DT29T5E8H6/WZNxR/XlYtlp3Pc7Yvj9P1eSeNv3HC/NTDItBRC4wxgKfEUlhZJ4lZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729619230; c=relaxed/simple;
	bh=FlzAbp/MpdQyzh+K8hBdQtACT1TABdVqqz+kTWPLk1k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iyaaXT1bs9jCXs3xlF3G6mD/nHJhR10Tfa67nDvgzj5ne5DG3asnW71FmRgO9GmXhi+NXoNq/+GcNXe21zAVSDMk2v0zUr5q/guJX4apOud5tZNaA6TTgzglusPbTt0ks+cit/k0vkvDQhl6DFgESbfm5fTQeNZ085Kt5vm3FOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TMZdZq7/; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7093997dffdso1899952a34.2
        for <dmaengine@vger.kernel.org>; Tue, 22 Oct 2024 10:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729619227; x=1730224027; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/3ROG2OgFC6S+UkSzKtSeK7aKbtjVl+W6QaKu0EpfgA=;
        b=TMZdZq7/h06w9TiDr3SqwGMKJwdNpwiHNzg585uCTUfgcMVtGkiObh6cDvcQajID4c
         xwmkC/Xl8l/jtMWNoEwckzB7w02eIkJDyjwDhgfcbVw8Vu12/bXq8L43aEo3WJyDvU9+
         pFzmX45qPvGIU7JJLBf2r8CBVhjU/9XV+Fcp5jZPCNVKhHaP9K7ciTGzTKME3Uoemg58
         9gId6j25CLcDWi3gEb4Z7deVrphNEZC0+lXnR5LwnPtlLnyr8Ib9hJz4Pm+TpHNjSrNV
         GRV2V4mrvSp6D5B6xaTqfYBYJe+WucxpYKWc9Hry/7e5LUJlHrLEV+n5P9xuOrdpOHqZ
         Ikgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729619227; x=1730224027;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3ROG2OgFC6S+UkSzKtSeK7aKbtjVl+W6QaKu0EpfgA=;
        b=DPyPAjR679as3l4HsipEf9YI1lu+XtMy4qKtwYdoIFM7Gsxd2gHjDYkVyB/HEz6cVK
         5A5BlRw7w1RWsSBkY1Y0Ifb9drGhAU1UwWQzbrNUm/cwiVFZtjUhmGbzv8nvoKEOZHBW
         Qc8wGDuV48N5TgzawR3WJuuuWs0l8o1k7K9I5ca/xADr09atcEW8hLCBPMbXUFz9Yv8W
         Mymnwhd9aKJxwIF1l3QzlBPeL2UItBd8rji9QK1HqdRcvMgp3xa8N1NKFtl8ENnrsBoh
         B2GgI6/9ENGGi1eQ0XU4lcVzintZI7T7AD2a8/WS4qPpeZO/3XuHgyQNkHsKSfmgKgwz
         da6g==
X-Forwarded-Encrypted: i=1; AJvYcCWyAN8XbVzFe9/uZQggKjySb6RGB7V9BeNYAbWKj1V3pyIB57e6Pvb/kkzHVNI6rOmsBTkNcYpHzug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh122cD+CW5Q6iTgu/AVQI+94Hvw91vuaNolM0toJ/f5S0iMfG
	JEzVx13oPxpGDTm2UxZHe9IQAd9tuBbdm1bLNFSvhJy0wMkzh1hAZ4zcII9QOOI=
X-Google-Smtp-Source: AGHT+IGgxcxo+adSxHU9+SGY77xlzKKVjgiC07fyJqCqhErk5/yWbcxxOxhTJG2ooD3rK8VwR9BxCg==
X-Received: by 2002:a05:6830:6f01:b0:718:10ce:c6a7 with SMTP id 46e09a7af769-7184b348e49mr31285a34.30.1729619227325;
        Tue, 22 Oct 2024 10:47:07 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7182eb22312sm1353300a34.13.2024.10.22.10.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 10:47:07 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] dt-bindings: dma: adi,axi-dmac: convert to yaml and
 update
Date: Tue, 22 Oct 2024 12:46:39 -0500
Message-Id: <20241022-axi-dma-dt-yaml-v1-0-68f2a2498d53@baylibre.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP/kF2cC/x3MSwqAMAwA0atI1gZsEEWvIi5iGzXgj1akIt7d4
 vItZh4I4lUCtNkDXi4Num8JJs/AzrxNguqSgQoqTUGEHBXdyuhOvHld0Fa2NuxIhkYgVYeXUeN
 /7Pr3/QDPGey8YQAAAA==
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Convert the ADI AXI DMAC bindings to YAML and then update the bindings
to reflect the current actual use of the bindings.

---
David Lechner (2):
      dt-bindings: dma: adi,axi-dmac: convert to yaml schema
      dt-bindings: dma: adi,axi-dmac: deprecate adi,channels node

 .../devicetree/bindings/dma/adi,axi-dmac.txt       |  61 ----------
 .../devicetree/bindings/dma/adi,axi-dmac.yaml      | 127 +++++++++++++++++++++
 2 files changed, 127 insertions(+), 61 deletions(-)
---
base-commit: 52a53aecddb1b407268ebc80695c38e5093dc08f
change-id: 20241022-axi-dma-dt-yaml-c6c71ad2eb9e

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


