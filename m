Return-Path: <dmaengine+bounces-1494-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FAA88BCD7
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 09:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32682E4210
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 08:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463CC14F62;
	Tue, 26 Mar 2024 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vjhhQ70i"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A903679D3
	for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443185; cv=none; b=J1dhaZ+qv/aNwu+4oQr+o+JFSQ8AxK2xOSKnm266EFZPRoXhB7rGpAsoEn6S2gBsoN3Fo5lEfPIk182HQJ1k2zp3z9/aUw1ShBprIP2So4MlUR3WuDOmlI2iT0gYBYQsZbnYrfSVhSDOh7xRBx5k+xe5hzovZT6jtnHxAzefQ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443185; c=relaxed/simple;
	bh=/42NS2BAKyjXyOi0zreo1tHDBvuPueV06zeTxHceIsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GEuO2SoeOPbdWsQSRUthm3I/QU5J1VVpnRuK6Ok/IMRSs9k2kpZ/glYe7DbTDY5UPSGo9is7bxaSHiOvE0RAe5U+O0T+0JYoXn4kHYb2zV9cUTs+J7dmuin2opHdLHzSGNK3/rEBQUAVa7WVaQpXd7eaai/BzhRtLxOwKCStIBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vjhhQ70i; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6f4ad4c57so3966136b3a.2
        for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 01:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711443183; x=1712047983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ejTqyrGZ36rIKhT+9PpsbQ1ocYMmLGk8UukNGZpcx40=;
        b=vjhhQ70iQo4yX38L9YqV5I/j1WAULG7y2OmR6+We2Jjic27++lusO6kvE2NQAiTby5
         Kk/9f3JjLuEeMVFuk/dbPPQCNu4snuKkit542N0omykBCA4sJ2VBf+hzuiVdx1nvtcyc
         r27NoSEITJ7uEiF2QxfPw51EvHjLAQS/EsOOxG3tKANPrdMtVigJRVnh5alE5FSuuLNJ
         csFanZtq8sjbvZVnYDO381YN9zxEEwuRpNfx1hwvZNV+MBch1G7ASuee42DTqxzRjdFy
         VAoUedBlcgghxdzX4h6oqr5PMivz5T22s1bu0rXBOY0B93mTMW6bdEblWP7I7qBl8Gq2
         560A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711443183; x=1712047983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejTqyrGZ36rIKhT+9PpsbQ1ocYMmLGk8UukNGZpcx40=;
        b=E42L6RZRo8JhL02vSA+OnJ/TLtwLsZrSvrMqYTJLGWQrG6F1R/7tjXgEf92ErgyKF3
         qGcFv+X/vW/0jvf47QfnraiOyIckIkJKscmGJnfrhJPNA02Ya7Qom1dWJXnQg9dkMYMS
         yi0uC+Q7TTGm/u8Lgan0tKgSzmKtttJyqrZy7U1OXpe3FgaGIQ1WLQfGmi8sYB+ntmxL
         MBqJyi4mVBJlTvVI1bLLbjZnegRvhK9Ltmoq+Dx0xNjhBYz/e+9YS99O5CHuss1wAQl5
         DEvbwTbCuSXBdpL8tg3jNG1zTuK9EsBDKcqpTmwX2Fv4fTnxUGf8d0SImWeX+6TYfMzR
         t0zw==
X-Forwarded-Encrypted: i=1; AJvYcCXoGaxWqFvthGv8rfVxGfU+oyklz9LThoef0xK5cSesr7Xj1j7bUo3cBYcYFahaDT3wGEYu9MPKdP+XKFLQU2LBczNqjzybDNlh
X-Gm-Message-State: AOJu0YyPWJrE4NlFVsAMXtk4Mo3AqIZLVh46gdHXNbVhP0t9qaKqQMuU
	E6sW+e3mD1qPIW73VlGxV/AQ/B7j2wL+ESI+CnoLCM0KstZxUUmR67mTURpyVz/EcAwY/j9Mixg
	=
X-Google-Smtp-Source: AGHT+IEbXcgAvO1hc0qzSk3N4dXDW6pyMF+VKiwJB+RZzxMqiEcoDGSosOqnRxJsBbjlKdXTYGoLdQ==
X-Received: by 2002:a05:6a21:2d88:b0:1a3:bb8b:de7a with SMTP id ty8-20020a056a212d8800b001a3bb8bde7amr10995463pzb.54.1711443182848;
        Tue, 26 Mar 2024 01:53:02 -0700 (PDT)
Received: from localhost.localdomain ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id d3-20020a170903230300b001e0b3a87dbbsm4425153plh.177.2024.03.26.01.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 01:53:02 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: vkoul@kernel.org
Cc: fancer.lancer@gmail.com,
	dmaengine@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] MAINTAINERS: Drop Gustavo Pimentel as EDMA Reviewer
Date: Tue, 26 Mar 2024 14:22:56 +0530
Message-Id: <20240326085256.12639-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gustavo Pimentel seems to have left Synopsys, so his email is bouncing.
And there is no indication from him expressing willingless to
continue contributing to the driver.

So let's drop him from the MAINTAINERS entry.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..9038abd8411e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6067,7 +6067,6 @@ F:	drivers/mtd/nand/raw/denali*
 
 DESIGNWARE EDMA CORE IP DRIVER
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
-R:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
 R:	Serge Semin <fancer.lancer@gmail.com>
 L:	dmaengine@vger.kernel.org
 S:	Maintained
-- 
2.25.1


