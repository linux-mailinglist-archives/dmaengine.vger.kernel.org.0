Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33466B2EFC
	for <lists+dmaengine@lfdr.de>; Sun, 15 Sep 2019 09:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfIOH1W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 15 Sep 2019 03:27:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45136 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfIOH1V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 15 Sep 2019 03:27:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id x3so15111303plr.12;
        Sun, 15 Sep 2019 00:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GTvFcpOUyieP9opBGHsT+B42cxzpcATMaoHH0I+0J1I=;
        b=dtYKXDrGv9xWSDJp5V4bb6UhJfXvdsElJS9v+PO1KZtmJZ+kYN/G9D3z6k7JM5CHjl
         97txUbvRcF+RpggFFczLZtTVvIJYile1i3reqybCb/H3+gbeLHONkPJS5Kl/hRRTSemP
         EX1Lfy+5tAcaww7+Jb4+QM4lWaq6m6ElB/Umpe07KOq+sHYnNAwsgetIDMkW45Iybgcu
         ULay1kOBUmL/Ncvogpmx2RwNnx6xz6hbBxhmniOsGcKJOakPjT2YlxE6vYMjpjcr/4+1
         rZscGGbTSeHWS/kccuXE5kcR/7+tA/x+jl3APtzJL+6qFag8BemK+9WG0Rni+V/Qlaco
         18mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GTvFcpOUyieP9opBGHsT+B42cxzpcATMaoHH0I+0J1I=;
        b=SCgKNE0/0nnyhjqHA8KIcorDjRlJJdKdkFZJuvXA4Uu688000nc2MFiVS35yjNimj0
         trD9T5OGHYTDVf/YoCMDodtaob05Lq4oVenB5zbVzd89ZI0Byb8V6uY+PgWmwDNalzaR
         WpqLzrayAQw/VAez0uxiMtkVDgbuP9o4xkK3hQs3goR28wSMGNzTlWfeneVv1lwD7hPM
         nfB6CXwQviDEjWkyzjk/dTdkKqXeKAFcmFFlSIHiwURJpElm4/gbvjCarGJnG9oEo3B9
         mFYKaUMdbfjMGQ9S6SSiwVZKq1LagB/8zmp8t4scXk1uJohJkPvs8mHftCN9JHX2Ib6Q
         0t1w==
X-Gm-Message-State: APjAAAVODRPA11dWSxNh2Aa7uHDzjDYjNOVNslzmA5xQfvb5VZ3Mq9l5
        uNVbtaUvrppWuOP/YThq0tE=
X-Google-Smtp-Source: APXvYqwfyHgYY759f5pUy7ZvnMQo/+BDd2d/wdpUuKRx33ViG0X3MEVEEhSs02ToRewoskfhy8mbOA==
X-Received: by 2002:a17:902:820f:: with SMTP id x15mr37974997pln.130.1568532439090;
        Sun, 15 Sep 2019 00:27:19 -0700 (PDT)
Received: from satendra-MM061.ib-wrb304n.setup.in ([103.82.150.111])
        by smtp.gmail.com with ESMTPSA id i19sm7254486pjx.1.2019.09.15.00.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 00:27:18 -0700 (PDT)
From:   Satendra Singh Thakur <sst2005@gmail.com>
To:     dan.j.williams@intel.com, vkoul@kernel.org, jun.nie@linaro.org,
        shawnguo@kernel.org, agross@kernel.org, sean.wang@mediatek.com,
        matthias.bgg@gmail.com, maxime.ripard@bootlin.com, wens@csie.org,
        lars@metafoo.de, afaerber@suse.de, manivannan.sadhasivam@linaro.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, satendrasingh.thakur@hcl.com,
        Satendra Singh Thakur <sst2005@gmail.com>
Subject: [PATCH 1/9] probe/dma : added helper macros to remove redundant/duplicate code from probe functions of the dma controller drivers
Date:   Sun, 15 Sep 2019 12:56:44 +0530
Message-Id: <20190915072644.23329-1-sst2005@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190915070003.21260-1-sst2005@gmail.com>
References: <20190915070003.21260-1-sst2005@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

1. For most of the drivers probe include following steps

a) memory allocation for driver's private structure
b) getting io resources
c) io remapping resources
d) getting clock
e) getting irq number
f) registering irq
g) preparing and enabling clock
i) setting platform's drv data

2. We have defined a set of macros to combine above mentioned
steps.
This will remove redundant/duplicate code in drivers' probe
functions.

3. This macro combines all the steps except f), g) and i).

devm_platform_probe_helper(pdev, priv, clk_name);

4. This macro combines all the steps except f) and i).

devm_platform_probe_helper_clk(pdev, priv, clk_name);

5. This macro combines all the steps except g) and i).

devm_platform_probe_helper_irq(pdev, priv, clk_name,
	irq_hndlr, irq_flags, irq_name, irq_devid);

6. This is because, some drivers perform step f) and g)
after hw init or subsys registration at very different points
in the probe function. The step i) is called at the end of
probe function by several drivers; while other drivers call it at
different points in probe function.

7. This macro combines above mentioned steps a) to g).

devm_platform_probe_helper_all(pdev, priv, clk_name,
	irq_hndlr, irq_flags, irq_name, irq_devid);

8. This macro combines all of the above mentioned steps a) to i).

devm_platform_probe_helper_all_data(pdev, priv, clk_name,
	irq_hndlr, irq_flags, irq_name, irq_devid);
9. Above macros will be useful for wide variety of probe
functions of different drivers.

Signed-off-by: Satendra Singh Thakur <satendrasingh.thakur@hcl.com>
Signed-off-by: Satendra Singh Thakur <sst2005@gmail.com>
---
 include/linux/probe-helper.h | 179 +++++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)
 create mode 100644 include/linux/probe-helper.h

diff --git a/include/linux/probe-helper.h b/include/linux/probe-helper.h
new file mode 100644
index 000000000000..7baa468509e3
--- /dev/null
+++ b/include/linux/probe-helper.h
@@ -0,0 +1,179 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *
+ * probe_helper.h - helper functions for platform drivers' probe
+ * function
+ * Author: Satendra Singh Thakur <satendrasingh.thakur@hcl.com> Sep 2019
+ *				  <sst2005@gmail.com>
+ */
+#ifndef _PROBE_HELPER_H_
+#define _PROBE_HELPER_H_
+
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+
+/* devm_platform_probe_helper - Macro for helping probe method
+ * of platform drivers
+ * This macro combines the functions:
+ * devm_kzalloc, platform_get_resource, devm_ioremap_resource,
+ * devm_clk_get, platform_get_irq
+ * @pdev platform device
+ * @priv driver's private object for memory allocation
+ * @clk_name clock name as in DT
+ */
+#define devm_platform_probe_helper(pdev, priv, clk_name)	\
+({	\
+	__label__ __out;	\
+	int __ret = 0;	\
+	priv = devm_kzalloc(&(pdev)->dev, sizeof(*priv), GFP_KERNEL);	\
+	if (!(priv)) {	\
+		dev_err(&(pdev)->dev, "devm_kzalloc failed\n");	\
+		__ret = -ENOMEM;	\
+		goto __out;	\
+	}	\
+	(priv)->base = devm_platform_ioremap_resource(pdev, 0);	\
+	if (IS_ERR((priv)->base)) {	\
+		dev_err(&(pdev)->dev,	\
+			"devm_platform_ioremap_resource failed\n");	\
+		__ret = PTR_ERR((priv)->base);	\
+		goto __out;	\
+	}	\
+	(priv)->clk = devm_clk_get(&(pdev)->dev, clk_name);	\
+	if (IS_ERR((priv)->clk)) {	\
+		dev_err(&(pdev)->dev, "devm_clk_get failed\n");	\
+		__ret = PTR_ERR((priv)->clk);	\
+		goto __out;	\
+	}	\
+	(priv)->irq = platform_get_irq(pdev, 0);	\
+	if ((priv)->irq < 0) {	\
+		dev_err(&(pdev)->dev, "platform_get_irq failed\n");	\
+		__ret = (priv)->irq;	\
+		goto __out;	\
+	}	\
+__out:	\
+	__ret;	\
+})
+
+/* devm_platform_probe_helper_irq - Macro for helping probe method
+ * of platform drivers
+ * This macro combines the functions:
+ * devm_kzalloc, platform_get_resource, devm_ioremap_resource,
+ * devm_clk_get, platform_get_irq, devm_request_irq
+ * @pdev platform device
+ * @priv driver's private object for memory allocation
+ * @clk_name clock name as in DT
+ * @irq_hndlr interrupt handler function (isr)
+ * @irq_flags flags for interrupt registration
+ * @irq_name name of the interrupt handler
+ * @irq_devid device identifier for irq
+ */
+#define devm_platform_probe_helper_irq(pdev, priv, clk_name,	\
+		irq_hndlr, irq_flags, irq_name, irq_devid)	\
+({	\
+	__label__ __out;	\
+	int __ret = 0;	\
+	__ret = devm_platform_probe_helper(pdev, priv, clk_name);	\
+	if (__ret < 0)	\
+		goto __out;	\
+	__ret = devm_request_irq(&(pdev)->dev, (priv)->irq, irq_hndlr,	\
+			irq_flags, irq_name, irq_devid);	\
+	if (__ret < 0) {	\
+		dev_err(&(pdev)->dev,	\
+			"devm_request_irq failed for irq num %d\n",	\
+			(priv)->irq);	\
+		goto __out;	\
+	}	\
+__out:	\
+	__ret;	\
+})
+
+/* devm_platform_probe_helper_clk Macro - for helping probe method
+ * of platform drivers
+ * This macro combines the functions:
+ * devm_kzalloc, platform_get_resource, devm_ioremap_resource,
+ * devm_clk_get, platform_get_irq, clk_prepare_enable
+ * @pdev platform device
+ * @priv driver's private object for memory allocation
+ * @clk_name clock name as in DT
+ */
+#define devm_platform_probe_helper_clk(pdev, priv, clk_name)	\
+({	\
+	__label__ __out;	\
+	int __ret = 0;	\
+	__ret = devm_platform_probe_helper(pdev, priv, clk_name);	\
+	if (__ret < 0)	\
+		goto __out;	\
+	__ret = clk_prepare_enable((priv)->clk);	\
+	if (__ret < 0) {	\
+		dev_err(&(pdev)->dev, "clk_prepare_enable failed\n");	\
+		goto __out;	\
+	}	\
+__out:	\
+	__ret;	\
+})
+
+/* devm_platform_probe_helper_all - Macro for helping probe method
+ * of platform drivers
+ * This macro combines the functions:
+ * devm_kzalloc, platform_get_resource, devm_ioremap_resource,
+ * devm_clk_get, platform_get_irq, devm_request_irq,
+ * clk_prepare_enable
+ * @pdev platform device
+ * @priv driver's private object for memory allocation
+ * @clk_name clock name as in DT
+ * @irq_hndlr interrupt handler function (isr)
+ * @irq_flags flags for interrupt registration
+ * @irq_name name of the interrupt handler
+ * @irq_devid device identifier for irq
+ */
+#define devm_platform_probe_helper_all(pdev, priv, clk_name,	\
+	irq_hndlr, irq_flags, irq_name, irq_devid)	\
+({	\
+	__label__ __out;	\
+	int __ret = 0;	\
+	__ret = devm_platform_probe_helper_clk(pdev, priv, clk_name);	\
+	if (__ret < 0)	\
+		goto __out;	\
+	__ret = devm_request_irq(&(pdev)->dev, (priv)->irq,	\
+		irq_hndlr, irq_flags, irq_name, irq_devid);	\
+	if (__ret < 0) {	\
+		dev_err(&(pdev)->dev,	\
+			"devm_request_irq failed for irq num %d\n",	\
+			(priv)->irq);	\
+		if ((priv)->clk)	\
+			clk_disable_unprepare((priv)->clk);	\
+		goto __out;	\
+	}	\
+__out:	\
+	__ret;	\
+})
+
+/* devm_platform_probe_helper_all_data - Macro for helping probe method
+ * of platform drivers
+ * This macro combines the functions:
+ * devm_kzalloc, platform_get_resource, devm_ioremap_resource,
+ * devm_clk_get, platform_get_irq, devm_request_irq,
+ * clk_prepare_enable, platform_set_drvdata
+ * @pdev platform device
+ * @priv driver's private object for memory allocation
+ * @clk_name clock name as in DT
+ * @irq_hndlr interrupt handler function (isr)
+ * @irq_flags flags for interrupt registration
+ * @irq_name name of the interrupt handler
+ * @irq_devid device identifier for irq
+ */
+#define devm_platform_probe_helper_all_data(pdev, priv, clk_name,	\
+	irq_hndlr, irq_flags, irq_name, irq_devid)	\
+({	\
+	__label__ __out;	\
+	int __ret = 0;	\
+	__ret = devm_platform_probe_helper_all(pdev, priv, clk_name,	\
+		irq_hndlr, irq_flags, irq_name, irq_devid);	\
+	if (__ret < 0)	\
+		goto __out;	\
+	platform_set_drvdata(pdev, priv);	\
+__out:	\
+	__ret;	\
+})
+
+#endif /*_PROBE_HELPER_H_*/
-- 
2.17.1

