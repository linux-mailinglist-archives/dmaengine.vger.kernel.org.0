Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4602758883
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2019 19:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfF0Rfw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Jun 2019 13:35:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33041 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfF0Rfv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Jun 2019 13:35:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so1590411pfq.0;
        Thu, 27 Jun 2019 10:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=01KFyhJUV3RoNriqLf5yZvf+oiqWf/wBU4j/uLg4Xuc=;
        b=uBVdbE3Jhxyv437CFJJGnINzZBdXk56Qp/pNpZfZPaOVfVl+sZMXIyYzWjz8o0VFnJ
         T+JSipaAlS39HZMZj0VHrh5JLWeYKWebAhdklZafCZzcg8OnY3Ev3gx3zHCi1p9pmUYW
         Lf1rupKSulkylrYR17QzTHWsFDKqc2zLyd8zaAcCT7NurEi89oquIGSkmr/cGCKN6D1m
         8r4MqtBJmIQ7xPm6zn+kW2YGk2ElBGUveuQ3AZWvEmJmINhu4x2v4BEi7lJKh3BVPwGg
         2olzaHXAxVT9n3DBpWU8gxoD1qZPQVbZM/sDKnRTzXt+hoVP+po5g+GYJ2q1+hdki7r3
         P70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=01KFyhJUV3RoNriqLf5yZvf+oiqWf/wBU4j/uLg4Xuc=;
        b=avtPmgt36j/jua3Y6oAM+Jg6LJZidjpZXWuMFJk2ZYpMGkxhDq+T1HXB0sILvOZOE6
         xtL6mLN4IeVJ3CwuXv2w9Kb9MGITxZvYU5DI8zHdaUREqxuAPbobmw+wlf1Fjj6mQLcq
         Nwg4fIeAXqWpeWNIzX1tnHVT0Rp4qQS3lTS9fajPi+93ft+SJMG4hNh0LedYN8Ua0MLf
         tJ5RhvWp1JdyrbkScesfEtvKzxCtLKvRxxeImxd+VeKS7VP5s4KlOr7tdlQJ4ZGUO5py
         dbkjADn1zmlx7C7+iBN9qX12I2wHQI5b8OamVtIvarKNtZoh7uEULyaDrqbzLIzOfYJH
         +YPQ==
X-Gm-Message-State: APjAAAWQH3nNT6dih0BCxVrOJWrk3dLYCF2nVBI2ZVmlcUiWpDbOIMOh
        j2bL5SRvjIRjUb5LG9Q4m5wQcJzXqJTkKw==
X-Google-Smtp-Source: APXvYqx+SNOeQczFkdaeBwmZhm/+mJTRZpohDTl9JOaOaz6UQcducOrh5q7I2LNI6Zl46a6QPO1zNg==
X-Received: by 2002:a63:c34c:: with SMTP id e12mr4711054pgd.195.1561656951061;
        Thu, 27 Jun 2019 10:35:51 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id p68sm4011548pfb.80.2019.06.27.10.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:35:50 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Sinan Kaya <okaya@kernel.org>, Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/87] qcom: hidma_ll: Remove call to memset after dmam_alloc_coherent
Date:   Fri, 28 Jun 2019 01:35:44 +0800
Message-Id: <20190627173544.2509-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

    In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
    dmam_alloc_coherent has already zeroed the memory.
    So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/dma/qcom/hidma_ll.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index 5bf8b145c427..bb4471e84e48 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -749,7 +749,6 @@ struct hidma_lldev *hidma_ll_init(struct device *dev, u32 nr_tres,
 	if (!lldev->tre_ring)
 		return NULL;
 
-	memset(lldev->tre_ring, 0, (HIDMA_TRE_SIZE + 1) * nr_tres);
 	lldev->tre_ring_size = HIDMA_TRE_SIZE * nr_tres;
 	lldev->nr_tres = nr_tres;
 
@@ -769,7 +768,6 @@ struct hidma_lldev *hidma_ll_init(struct device *dev, u32 nr_tres,
 	if (!lldev->evre_ring)
 		return NULL;
 
-	memset(lldev->evre_ring, 0, (HIDMA_EVRE_SIZE + 1) * nr_tres);
 	lldev->evre_ring_size = HIDMA_EVRE_SIZE * nr_tres;
 
 	/* the EVRE ring has to be EVRE_SIZE aligned */
-- 
2.11.0

