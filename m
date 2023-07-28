Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6634766AD8
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jul 2023 12:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbjG1Kh4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jul 2023 06:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbjG1Khn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Jul 2023 06:37:43 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86F844AF
        for <dmaengine@vger.kernel.org>; Fri, 28 Jul 2023 03:34:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso13560645e9.0
        for <dmaengine@vger.kernel.org>; Fri, 28 Jul 2023 03:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690540482; x=1691145282;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JhU0/s1FIjXEwNcoDV9X+JLSmnYUPHPn4uOC0VWbRjg=;
        b=yCjLvn+5QF0odzxQO2yeNWOFRCblU2VJBvFNRkxiLtqdazEISt18XUW6Qb5aPXEsBG
         jB91cKKRnNsHCDeN7ADYhjcH/IBpF9RLp8BV7fTuA9sQI6dliU2axwBGIdkLtOqQFiP6
         8UVTixIgPMIMeATgvJ/tzmFoXiUQTe/5DF86C5hVO7SfRw7/VhdCf00Pe6ipFxftUlLj
         Yemoat0BDM131tz/tvJjl76UUDYhOfwwuLy3oAD51iQOyFv0PLxrP6mve67Cc5LlC9wV
         MQcNX6HNWbLM9VnzEDsMakIVe7DOngzfsguf0gpJ2RFHERNnEAvFvCsa2ZxBOhcchmt8
         TXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690540482; x=1691145282;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JhU0/s1FIjXEwNcoDV9X+JLSmnYUPHPn4uOC0VWbRjg=;
        b=eE7yeCJh07m8+uGxNGh84oj9YbTAFMz/1PAPplN+03aleSth23PlgRa04Q7tk961DH
         BzUcqYIt5TcUiPVIDM8rTQaBvQ81Of//jhClOZKcFBQSsJ6BDbqy1RcFymyLZWZZB+vn
         3Yr9SIe9S62fHQLCn57ClGyQyW6l/Zh3fFlHdsAZBNF5EWbC9hWnG4KHGZBrdb2zUSIC
         zAYWY/PNxxo10zPuizqT3oobTCpSI2F2ANYwNEXiWE3n4yPslt/5GP0y381rHEskOC6J
         U+TBh7qndUO/RS2RMGdIfVwhe916/lUKW1l/UyLaudHIgYz/Hgpd0TEZH8ypvzULlSL7
         ZWDQ==
X-Gm-Message-State: ABy/qLY1NCIa/DBBGwmEgsBfIp4W/v+IvUKO8vxn2rHjtvno4rKL0k4X
        nhq6e+iVbRyYPoBz10wirfyqPw==
X-Google-Smtp-Source: APBJJlGJ4kYzmHSYjVxYBQs/Q/D2MdYfs/FkiZ1pEIW9Sl6YvVsK1iHII/9j5PIdPYqV48WghJpjlA==
X-Received: by 2002:a05:600c:b89:b0:3fb:ebe2:6f5f with SMTP id fl9-20020a05600c0b8900b003fbebe26f5fmr3985019wmb.13.1690540482205;
        Fri, 28 Jul 2023 03:34:42 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c1c0600b003fc3b03caa5sm8847758wms.1.2023.07.28.03.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 03:34:41 -0700 (PDT)
Date:   Fri, 28 Jul 2023 13:34:37 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     alain.volmat@foss.st.com
Cc:     dmaengine@vger.kernel.org
Subject: [bug report] spi: stm32: use dmaengine_terminate_{a}sync instead of
 _all
Message-ID: <2d14afcb-c269-4cf1-aeea-ce37cad52d30@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Alain Volmat,

The patch 4f2b39dc2d14: "spi: stm32: use dmaengine_terminate_{a}sync
instead of _all" from Jun 15, 2023 (linux-next), leads to the
following Smatch static checker warning:

	include/linux/dmaengine.h:1185 dmaengine_terminate_sync()
	warn: sleeping in atomic context

./include/linux/dmaengine.h
    1177 static inline int dmaengine_terminate_sync(struct dma_chan *chan)
    1178 {
    1179         int ret;
    1180 
    1181         ret = dmaengine_terminate_async(chan);
    1182         if (ret)
    1183                 return ret;
    1184 
--> 1185         dmaengine_synchronize(chan);
    1186 
    1187         return 0;
    1188 }

The problem is that the error handling code calls dmaengine_terminate_sync()
while holding a spinlock.

stm32_spi_transfer_one_dma() <- disables preempt
-> dmaengine_terminate_sync()

It used to be dmaengine_terminate_all().  Probably that was buggy as
well, but just too complicated for Smatch to warn about.  Another idea
is to call dmaengine_terminate_async() (I don't know the code at all,
possibly that is a stupid idea).

regards,
dan carpenter
