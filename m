Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D99914D6
	for <lists+dmaengine@lfdr.de>; Sun, 18 Aug 2019 07:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfHRFRF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Aug 2019 01:17:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35180 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfHRFRE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Aug 2019 01:17:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id n4so5045309pgv.2;
        Sat, 17 Aug 2019 22:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GYojZGC5006nwo6kR7R2OZwjHJuHZ/9aX9d0KGWKaQU=;
        b=twnB7ogm/4eFH+xL0A74M/BWrNx6MEwPEsjywUDNZjBbQgtqY0UzUuJ78mNXP/n3gC
         xKgyjRny40bsqyVNJGc+Oxr1G2jzVe51W7ivC99YVTAgX7Kvf3kxLnSHux5DMzq43Unz
         ABfiaS2149XLWu2Zxm3Z3WCpoF/6zWfCX2uKugbD3SSshO3pqhAGnOPlDt6pn7BzSluc
         21HKfdevidRnNvdCzRpnqGg557IKiM0QKDO7K22HzAg7dmknvyEG1O2nKIV/Lshod1EL
         WD3k010kykKouBR9UqgKayd1SPwIn3kvBHXj1mS5mjE90lW+SxFxZf32GduvTIMwUIFG
         gVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GYojZGC5006nwo6kR7R2OZwjHJuHZ/9aX9d0KGWKaQU=;
        b=Dy++nVj6TIIvazoxJAFXDmj9jRhhn/tWQ/2iTwaBgpdJpV6ssgcFwoTIe7AH7Jezz3
         ajlBS5NFlfrHhYfLxYrQC+svtqzaaOdw2blaKY3sHmR8Z8EuRJkmG8NIYJsjtMiIyAEw
         vt0IMdJT3uQIpvWCNIgf8iEoAThqt2VpMMfjjjhZ8DyVhpIP08nwOFUv8QGEOpVvz4uw
         VHvK1tJUAWQIxB264zs7hBHfUxmpNWD6cAVOH054O6xso8oVD9cP2DwLfkF8lNDCVq91
         /+TI6ExoUR2vEFHM/G5JT/OcSnbHi38UlZfr7RJvWYCizXTRlbgLTYolAOHzMleCwqa3
         u2dQ==
X-Gm-Message-State: APjAAAVgCsOVv+JH8QUey/3aoYSvVQ5UE2lp0Q4DH/OIw1J5WZhZNAQY
        QPkJ7GrnGSiRMTVUS+WvJHg0z80n
X-Google-Smtp-Source: APXvYqy138emwbhHhKdukk9/lK+WWtnqmCrX9/OvUebxSQTdCNDqhK1h+iL0lzYNQNA1lv+zcATWZg==
X-Received: by 2002:a63:4a50:: with SMTP id j16mr14368297pgl.126.1566105423964;
        Sat, 17 Aug 2019 22:17:03 -0700 (PDT)
Received: from localhost.localdomain (S0106d80d17472dbd.wp.shawcable.net. [24.79.253.190])
        by smtp.gmail.com with ESMTPSA id 33sm9610386pgy.22.2019.08.17.22.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 22:17:03 -0700 (PDT)
From:   jassisinghbrar@gmail.com
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vkoul@kernel.org, robh+dt@kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH v2 0/2] Add support for AHB DMA controller on Milbeaut series
Date:   Sun, 18 Aug 2019 00:16:47 -0500
Message-Id: <20190818051647.17475-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190613005109.1867-1-jassisinghbrar@gmail.com>
References: <20190613005109.1867-1-jassisinghbrar@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

Changes since v1:
1) Drop uncessary headers from driver
2) Some Cosmetic changes.
3) Define macro for magic numbers
4) Specify constraints on number of channels/irq in DT bindings

Jassi Brar (2):
  dt-bindings: milbeaut-m10v-hdmac: Add Socionext Milbeaut HDMAC
    bindings
  dmaengine: milbeaut-hdmac: Add HDMAC driver for Milbeaut platforms

 .../bindings/dma/milbeaut-m10v-hdmac.txt      |  32 +
 drivers/dma/Kconfig                           |  10 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/milbeaut-hdmac.c                  | 571 ++++++++++++++++++
 4 files changed, 614 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/milbeaut-m10v-hdmac.txt
 create mode 100644 drivers/dma/milbeaut-hdmac.c

-- 
2.17.1

