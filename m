Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6594C6416A3
	for <lists+dmaengine@lfdr.de>; Sat,  3 Dec 2022 13:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiLCMTp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 3 Dec 2022 07:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLCMTj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 3 Dec 2022 07:19:39 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B139DF72
        for <dmaengine@vger.kernel.org>; Sat,  3 Dec 2022 04:19:38 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id h4-20020a1c2104000000b003d0760654d3so7000724wmh.4
        for <dmaengine@vger.kernel.org>; Sat, 03 Dec 2022 04:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a7x+/+Ppx7UEkTF+Fa2rtLyB4931yiiAaSvteC//fus=;
        b=YH3oUlxI9L/YTEWBZtwI7eOkXZztaXTqVY2UilMqGqGz/ZiDk/FeZi4yKcb449VxEx
         JObSzHZhoNqgCM/+oZlnvrz5BrVcqv6+msMB8X/COXls5XsjQcG6PUT8h/99wg+oR2Wq
         m/AIKkySZZgP+3Zdn+wefTKoeMNgTR2uDTuG1ri8Mo5FmzCM7mEjpCOjydQp6c7ZrvwO
         uedTXbB7xtrvnS0+dqK20+oIzhwMPC2f5nzlJX+P3h1stfK0O2aAHwIr9A5IvuodXZ2N
         Vlx5KFf0cr+Rt1of6wCycTPI6680grXZjk2NlqOVeDuRgCXHzDUViyyy29Bry6DgYaLu
         JEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7x+/+Ppx7UEkTF+Fa2rtLyB4931yiiAaSvteC//fus=;
        b=shl2AWxUFuiTulztJ57X1tshXt8FZwHlw/9fq7s71LMf0b1m6JsQrs9xddCbVm3t2k
         GjmFJSNWiXEas3mvHaTB2nc2CiLOwIQi6kPxz2XL4qu1LLBNmOhTCzcj24buch/lilrD
         n7xzi8Elt4BF6Sph26NwIR2eosDcHhV3kqLsZgZmn0u0JRqec25wLj8Xcd0kJMhnocTN
         9A9kHOmnXs35qNa7Q53An/r7UQLFtvJnU66r3CwFpG8PTXZD8I38zyo7Vy1qclKEMIti
         T7i1gYDVcGWW5Frv7lvRMJn9ScsCtxDGi67Ah534f7if3nKn/XnKa9lN52iG9huLhNDl
         o81A==
X-Gm-Message-State: ANoB5pnyUxTITQ/JXcpX3Y7NfGWaYHccCsmuDe3VeJriA1ZGi0fRFehv
        Q8OBwEP/NQVIk1v5n2T4KsvjafOzK30=
X-Google-Smtp-Source: AA0mqf6MZLPQYcUdu3D0sWJUa7uD7dLOkPkOQpzq1os7d7so0F6IGpJdDjgW4TV5MhIfgPG3pA1fRQ==
X-Received: by 2002:a05:600c:524a:b0:3cf:6a41:9aec with SMTP id fc10-20020a05600c524a00b003cf6a419aecmr41901074wmb.159.1670069977178;
        Sat, 03 Dec 2022 04:19:37 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c4e9200b003c6c182bef9sm21032119wmq.36.2022.12.03.04.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 04:19:36 -0800 (PST)
Date:   Sat, 3 Dec 2022 15:19:33 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     g.liakhovetski@gmx.de
Cc:     dmaengine@vger.kernel.org
Subject: [bug report] dmaengine: add a driver for AMBA AXI NBPF DMAC IP cores
Message-ID: <Y4s+1W+hovfZ0vx6@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

[ Ancient code, but still maybe the bug is easy to fix? -dan ]

Hello Guennadi Liakhovetski,

The patch b45b262cefd5: "dmaengine: add a driver for AMBA AXI NBPF
DMAC IP cores" from Jul 19, 2014, leads to the following Smatch
static checker warning:

	drivers/dma/nbpfaxi.c:1358 nbpf_probe()
	warn: potentially one past the end of array 'nbpf->chan[i]'

drivers/dma/nbpfaxi.c
    1291 static int nbpf_probe(struct platform_device *pdev)
    1292 {
    1293         struct device *dev = &pdev->dev;
    1294         struct device_node *np = dev->of_node;
    1295         struct nbpf_device *nbpf;
    1296         struct dma_device *dma_dev;
    1297         struct resource *iomem;
    1298         const struct nbpf_config *cfg;
    1299         int num_channels;
    1300         int ret, irq, eirq, i;
    1301         int irqbuf[9] /* maximum 8 channels + error IRQ */;
    1302         unsigned int irqs = 0;
    1303 
    1304         BUILD_BUG_ON(sizeof(struct nbpf_desc_page) > PAGE_SIZE);
    1305 
    1306         /* DT only */
    1307         if (!np)
    1308                 return -ENODEV;
    1309 
    1310         cfg = of_device_get_match_data(dev);
    1311         num_channels = cfg->num_channels;
    1312 
    1313         nbpf = devm_kzalloc(dev, struct_size(nbpf, chan, num_channels),
                                                      ^^^^^^^^^^^^^^^^^^^^^^^^
nbpf->chan[] has num_channels elements.

    1314                             GFP_KERNEL);
    1315         if (!nbpf)
    1316                 return -ENOMEM;
    1317 
    1318         dma_dev = &nbpf->dma_dev;
    1319         dma_dev->dev = dev;
    1320 
    1321         iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    1322         nbpf->base = devm_ioremap_resource(dev, iomem);
    1323         if (IS_ERR(nbpf->base))
    1324                 return PTR_ERR(nbpf->base);
    1325 
    1326         nbpf->clk = devm_clk_get(dev, NULL);
    1327         if (IS_ERR(nbpf->clk))
    1328                 return PTR_ERR(nbpf->clk);
    1329 
    1330         of_property_read_u32(np, "max-burst-mem-read",
    1331                              &nbpf->max_burst_mem_read);
    1332         of_property_read_u32(np, "max-burst-mem-write",
    1333                              &nbpf->max_burst_mem_write);
    1334 
    1335         nbpf->config = cfg;
    1336 
    1337         for (i = 0; irqs < ARRAY_SIZE(irqbuf); i++) {
    1338                 irq = platform_get_irq_optional(pdev, i);
    1339                 if (irq < 0 && irq != -ENXIO)
    1340                         return irq;
    1341                 if (irq > 0)
    1342                         irqbuf[irqs++] = irq;
    1343         }
    1344 
    1345         /*
    1346          * 3 IRQ resource schemes are supported:
    1347          * 1. 1 shared IRQ for error and all channels
    1348          * 2. 2 IRQs: one for error and one shared for all channels
    1349          * 3. 1 IRQ for error and an own IRQ for each channel
    1350          */
    1351         if (irqs != 1 && irqs != 2 && irqs != num_channels + 1)
                                                       ^^^^^^^^^^^^^^^^

    1352                 return -ENXIO;
    1353 
    1354         if (irqs == 1) {
    1355                 eirq = irqbuf[0];
    1356 
    1357                 for (i = 0; i <= num_channels; i++)
                                       ^^

--> 1358                         nbpf->chan[i].irq = irqbuf[0];
                                 ^^^^^^^^^^^^

Off by one because of the <=.  There are a bunch of weird
num_channels + 1 limits so it's not clear what's happening in this
function.

    1359         } else {
    1360                 eirq = platform_get_irq_byname(pdev, "error");
    1361                 if (eirq < 0)
    1362                         return eirq;
    1363 
    1364                 if (irqs == num_channels + 1) {
                                     ^^^^^^^^^^^^^^^^

    1365                         struct nbpf_channel *chan;
    1366 
    1367                         for (i = 0, chan = nbpf->chan; i <= num_channels;
                                                                ^^^^^^^^^^^^^^^^^^


    1368                              i++, chan++) {
    1369                                 /* Skip the error IRQ */
    1370                                 if (irqbuf[i] == eirq)
    1371                                         i++;
    1372                                 chan->irq = irqbuf[i];
    1373                         }
    1374 
    1375                         if (chan != nbpf->chan + num_channels)
    1376                                 return -EINVAL;
    1377                 } else {
    1378                         /* 2 IRQs and more than one channel */
    1379                         if (irqbuf[0] == eirq)
    1380                                 irq = irqbuf[1];
    1381                         else
    1382                                 irq = irqbuf[0];
    1383 
    1384                         for (i = 0; i <= num_channels; i++)
                                             ^^^^^^^^^^^^^^^^^

    1385                                 nbpf->chan[i].irq = irq;
    1386                 }
    1387         }
    1388 
    1389         ret = devm_request_irq(dev, eirq, nbpf_err_irq,
    1390                                IRQF_SHARED, "dma error", nbpf);
    1391         if (ret < 0)
    1392                 return ret;
    1393         nbpf->eirq = eirq;
    1394 
    1395         INIT_LIST_HEAD(&dma_dev->channels);
    1396 
    1397         /* Create DMA Channel */
    1398         for (i = 0; i < num_channels; i++) {
    1399                 ret = nbpf_chan_probe(nbpf, i);
    1400                 if (ret < 0)
    1401                         return ret;
    1402         }
    1403 
    1404         dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
    1405         dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
   
regards,
dan carpenter
