Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF031142D0
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2019 15:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfLEOiD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Dec 2019 09:38:03 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39412 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbfLEOiD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Dec 2019 09:38:03 -0500
Received: by mail-lj1-f195.google.com with SMTP id e10so3847862ljj.6
        for <dmaengine@vger.kernel.org>; Thu, 05 Dec 2019 06:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ySkkqpmB/BOI7Ew6QjgGxPInG6fWKDRrslVzVcjzv2c=;
        b=XC1fPf0WppSyHnQAs0FgBjmmzu2VwnQGY3yrZuC43dI2RW/Kx28FDMxjBy33dFTfa6
         /bFH8jm8Bynv744jXTDQGCXj4HjJfbcy9GXvtzGwRDAi3Ji/OGCkMqtjA8CEpdL+aPzL
         WJVYYaHnytbA8G7IYsyCLh6yFuqwWThgRIq2pidgRPzCFyO/+Mit2fMERYsV/wQbNCKD
         7TF2HF7To5RcdNPFgrUHXvFk0+TMlqdHEMCz1v/K/35MSR4+JxKy1tqdaLpSHMknCg1B
         JwtK0DrFT2dO8A3qxsMZzEay/eVgiKdC02k0IpEWoU/bTQ6kDlSZ3szayL7DP7w4vv1T
         I+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ySkkqpmB/BOI7Ew6QjgGxPInG6fWKDRrslVzVcjzv2c=;
        b=ct/0yXx/Pz3UMBmNq4Y4ar/l6kvqIt+XcEEMQ/o1kSuvF7zGdahKpnt65/B3SHN/sH
         eChiQQ9EZzofOuOKx76i3qXAFFmk28YnEoXYX+ni7qnuLqNRN0bYs3Wvm/d8ZxuwVnad
         BJLpiOGi9wujMQ5QtdJwQ9Dn3OD6xnSb1g6PhtzR08pkug47uU/1/fPQ68bH+K1ExlmO
         fTeFSleHjn9vhrkGbylCBOR2cgGAKkO4lHbEuk+nmmszOD8uKHZ0eJHmeCEz/Psgo1Qt
         i4r1a07mA3v/r5qxmj321KDwxX9BoSWQ1o++07lnVSOB2va4cvBMgPR6DnOJaxmonyXm
         vErw==
X-Gm-Message-State: APjAAAVTkXIIC9thtx4bMybD7DgXeRH/tDRq/IOEQ+a1lJCoTtolKeZ1
        xIAdVsh45n/smUNhmLCfoWDaiA==
X-Google-Smtp-Source: APXvYqw/h/AzAZZmHc8Wi5LZCEupiW1yZV+L37h/WwAkJOovQZvIEuVT13/j+Du7U19X/GkBibSBcQ==
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr3401650ljn.48.1575556680825;
        Thu, 05 Dec 2019 06:38:00 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q10sm5091294ljj.60.2019.12.05.06.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 06:38:00 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/2] dmaengine: pl330: A few system suspend/resume changes
Date:   Thu,  5 Dec 2019 15:37:44 +0100
Message-Id: <20191205143746.24873-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

I accidentally stumbled over a couple of things for the system suspend/resume
support in the pl330 driver, that I thought deserved to be improved. So here
there are, only compile tested, so far.

Kind regards
Ulf Hansson


Ulf Hansson (2):
  dmaengine: pl330: Drop boilerplate code for suspend/resume
  dmaengine: pl330: Convert to the *_late and *_early system sleep
    callbacks

 drivers/dma/pl330.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

-- 
2.17.1

