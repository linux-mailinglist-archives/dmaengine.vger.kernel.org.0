Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9092698DDC
	for <lists+dmaengine@lfdr.de>; Thu, 16 Feb 2023 08:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBPHfO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Feb 2023 02:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBPHfN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Feb 2023 02:35:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240163A088
        for <dmaengine@vger.kernel.org>; Wed, 15 Feb 2023 23:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676532862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K8gjNmTSR559OlRy9/RjmiyCYfUP8oDtfxDvTzbUrgI=;
        b=GrHFdTUnKl/Rqf9KKwIRDW2TBvroyQpUDrpNZTYcT9j9FnRv5jQS3HHECd/pmW8XjLOfY7
        f9ECpgQ2t5XZqP/1jPDOaw7mbxubE9lKaDaNzEprcDiwnWthdLcxHEBsUn9ikEUguAXZmQ
        yMRJTq2iETR6TSeJOq3WRCactU9oEu8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-qFMrDV1tMX6QrEoyM6s7bg-1; Thu, 16 Feb 2023 02:34:18 -0500
X-MC-Unique: qFMrDV1tMX6QrEoyM6s7bg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B46D811E6E;
        Thu, 16 Feb 2023 07:34:18 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-99.pek2.redhat.com [10.72.12.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F227C140EBF6;
        Thu, 16 Feb 2023 07:34:12 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [PATCH 2/2] dmaengine: make QCOM_HIDMA depend on HAS_IOMEM
Date:   Thu, 16 Feb 2023 15:34:03 +0800
Message-Id: <20230216073403.451455-2-bhe@redhat.com>
In-Reply-To: <20230216073403.451455-1-bhe@redhat.com>
References: <20230216073403.451455-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On s390 systems (aka mainframes), it has classic channel devices for
networking and permanent storage that are currently even more common
than PCI devices. Hence it could have a fully functional s390 kernel
with CONFIG_PCI=n, then the relevant iomem mapping functions
[including ioremap(), devm_ioremap(), etc.] are not available.

Here let QCOM_HIDMA depend on HAS_IOMEM so that it won't be built to
cause below compiling error if PCI is unset.

--------------------------------------------------------
ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
hidma.c:(.text+0x4b46): undefined reference to `devm_ioremap_resource'
ld: hidma.c:(.text+0x4b9e): undefined reference to `devm_ioremap_resource'
make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 1
make: *** [Makefile:1264: vmlinux] Error 2

Link: https://lore.kernel.org/all/Y0TcaZD4nB1w+mAQ@MiWiFi-R3L-srv/T/#u
Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dmaengine@vger.kernel.org
---
 drivers/dma/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/qcom/Kconfig b/drivers/dma/qcom/Kconfig
index 3f926a653bd8..ace75d7b835a 100644
--- a/drivers/dma/qcom/Kconfig
+++ b/drivers/dma/qcom/Kconfig
@@ -45,6 +45,7 @@ config QCOM_HIDMA_MGMT
 
 config QCOM_HIDMA
 	tristate "Qualcomm Technologies HIDMA Channel support"
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	help
 	  Enable support for the Qualcomm Technologies HIDMA controller.
-- 
2.34.1

