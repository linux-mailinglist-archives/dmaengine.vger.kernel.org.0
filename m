Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DC36865F4
	for <lists+dmaengine@lfdr.de>; Wed,  1 Feb 2023 13:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjBAMdK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Feb 2023 07:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBAMdI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Feb 2023 07:33:08 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ED2C15C
        for <dmaengine@vger.kernel.org>; Wed,  1 Feb 2023 04:33:07 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso1247093wmp.3
        for <dmaengine@vger.kernel.org>; Wed, 01 Feb 2023 04:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XRmrbfafZ2u/Btz65QhA5W17LjiB4tALokKgI/W8edE=;
        b=OKOKc9gas9i2/PI5SMgZnB9jaLNLXNIkaffBPLn1343o1kpur9OYxFCqr9INgZFh8L
         HdR11x0E2mbBcYSrJPYzqMNTUXDz3ZPbkrBVhujkeXkogNAOhutMeEG1djXOU2Id/zox
         zZH4DzAXzpRcj0bpNy9hREdiIhZh58ujg3yb7BoswLg4cCVzyA4jVE5W6EHga6s/gIwH
         BjzOC0q/jSYz5+8/M57hxCEaVaqmWYe2CiEBM0oLOUSyU0zwOOiyP4TLS3OVJo8W8ih7
         VxIchOvu0Oc0btv6Yw7nl/Kx9vwqmmxSSseqrLlmylEnBq8A8cV1IN5Ja172UyMYnqit
         jnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XRmrbfafZ2u/Btz65QhA5W17LjiB4tALokKgI/W8edE=;
        b=Ivl5KwEvTgJxLmnp0dSezCElUvSGj8EhMRZLwZcj+9s/iwQWuQaKGUb2ajFkIXJNuq
         QwzFaP/iZa13+gVekuuvg2iurcTtV2etL6JbwAYKQY+mlhQScG2TtNEkh7373Sdvt1Ak
         8tyWUcd1YH9pM4jOnEYbiMD/6buIgVfUxs2lM7V+jffqOdVE56t1fvt6HQEBLORW7x2N
         e3EErA8OWTFZiuHnPnKELWpWQtxhY5BwseHuTiJf9r9uLH/hTTJdaAlweioxC0SbS/yE
         ltumfruuSPOxL09K41LCbFyJYkC+lViumkfX80/1tORStfokk1glhqiJALrbYYO718vy
         fVwA==
X-Gm-Message-State: AO0yUKX75tkVwA/R7rOs81mFc8Bsw/SnBajQbFMfCCbJoa05dnKB7r8j
        V2SHwJOxPiIvFV6zTEGAx1c=
X-Google-Smtp-Source: AK7set8IgVC7vdS6cBbDvuHVO8lLXGXyLSwCKEJNifcWGmdpgNJfoljKHfM3mylXBNRRo0xTqrEeSA==
X-Received: by 2002:a1c:4c17:0:b0:3db:262a:8ef with SMTP id z23-20020a1c4c17000000b003db262a08efmr1924583wmf.38.1675254785897;
        Wed, 01 Feb 2023 04:33:05 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b003dc4b4dea31sm1889127wmq.27.2023.02.01.04.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 04:33:05 -0800 (PST)
Date:   Wed, 1 Feb 2023 15:32:42 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     okaya@codeaurora.org
Cc:     dmaengine@vger.kernel.org,
        Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
        cip-dev <cip-dev@lists.cip-project.org>
Subject: [bug report] dmaengine: add Qualcomm Technologies HIDMA management
 driver
Message-ID: <Y9pb6vRuK6WpsV3P@kili>
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

Hello Sinan Kaya,

The patch 7f8f209fd6e0: "dmaengine: add Qualcomm Technologies HIDMA
management driver" from Feb 4, 2016, leads to the following Smatch
static checker warning:

	drivers/dma/qcom/hidma_mgmt.c:101 hidma_mgmt_setup()
	warn: uncapped user loop index 'i'

drivers/dma/qcom/hidma_mgmt.c
    91         }
    92 
    93         if (mgmtdev->max_rd_xactions > HIDMA_MAX_RD_XACTIONS_MASK) {
    94                 dev_err(&mgmtdev->pdev->dev,
    95                         "max_rd_xactions cannot be bigger than %ld\n",
    96                         HIDMA_MAX_RD_XACTIONS_MASK);
    97                 return -EINVAL;
    98         }
    99 
    100         for (i = 0; i < mgmtdev->dma_channels; i++) {
--> 101                 if (mgmtdev->priority[i] > 1) {
                            ^^^^^^^^^^^^^^^^^^^^
The sysfs interface lets you set mgmtdev->dma_channels so this is an
array out of bounds access.  It's in hidma_mgmt_sys.c

drivers/dma/qcom/hidma_mgmt_sys.c
    26  #define IMPLEMENT_GETSET(name)                                  \
    27  static int get_##name(struct hidma_mgmt_dev *mdev)              \
    28  {                                                               \
    29          return mdev->name;                                      \
    30  }                                                               \
    31  static int set_##name(struct hidma_mgmt_dev *mdev, u64 val)     \
    32  {                                                               \
    33          u64 tmp;                                                \
    34          int rc;                                                 \
    35                                                                  \
    36          tmp = mdev->name;                                       \
    37          mdev->name = val;                                       \
    38          rc = hidma_mgmt_setup(mdev);                            \
    39          if (rc)                                                 \
    40                  mdev->name = tmp;                               \
    41          return rc;                                              \
    42  }
    43  
    44  #define DECLARE_ATTRIBUTE(name, mode)                           \
    45          {#name, mode, get_##name, set_##name}
    46  
    47  IMPLEMENT_GETSET(hw_version_major)
    48  IMPLEMENT_GETSET(hw_version_minor)
    49  IMPLEMENT_GETSET(max_wr_xactions)
    50  IMPLEMENT_GETSET(max_rd_xactions)
    51  IMPLEMENT_GETSET(max_write_request)
    52  IMPLEMENT_GETSET(max_read_request)
    53  IMPLEMENT_GETSET(dma_channels)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    54  IMPLEMENT_GETSET(chreset_timeout_cycles)

regards,
dan carpenter
