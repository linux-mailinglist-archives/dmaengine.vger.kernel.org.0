Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C2956C03C
	for <lists+dmaengine@lfdr.de>; Fri,  8 Jul 2022 20:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbiGHRB6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Jul 2022 13:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiGHRB6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Jul 2022 13:01:58 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03C01FCF1
        for <dmaengine@vger.kernel.org>; Fri,  8 Jul 2022 10:01:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o16-20020a05600c379000b003a02eaea815so1204330wmr.0
        for <dmaengine@vger.kernel.org>; Fri, 08 Jul 2022 10:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nNGh1W8H58m6hFFntBGmQsDqckIMVcWoGWG9fndPhMM=;
        b=k9sejQ7A6A9E+qrCG5qv+EmdgbxLhOer9B71faYs4psVSsAx38ujk2CS/BjFyeie8J
         6KxjTJGLDwAxsId8EWU0gTQV72j2VrUNZWyzv/EcnMUQ7Dtq/z+TVxX+p1hSID+1qwKR
         iBRSGPu3tyWEH8a8vDbPYVV6nTS3+EgJIlkrV24zQCc9HTc3J8hGfD3CiHLsjl32iIJw
         TWyeIQW+5S4gBOap8WChbFj7WGwz5OeXgvoEhQqFrH3KofVhAF6pieHn+3z73Oke0HIx
         DVi9Sgta8slOptnG524nZiY+QluAr7TdoCE7vnrbnYbgbWw01JlfVPn9fjQ5hq5RGdO+
         xbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nNGh1W8H58m6hFFntBGmQsDqckIMVcWoGWG9fndPhMM=;
        b=JlR+t/6+SX2lL/2j0nkNIZSS+jkO2ZBlX1yQ/OJdljd9c+k8zVmhw0/yaX/ocOHqH4
         8HPRgdTv5jiRHwaLYa9rlkl4ta/fEsFIzCi/a2DjJkn4D4G8IQe1M3NluQ22FDHfAo1/
         37ta8jaAE6slH3SXgQ6NYuk5jXmKeyK2j37fMQo/msG2gcPkuBzo5GV1RybkPEw2t2yf
         CWi3Nop32YMnTUd9xgN3kEt843Fikh1YNjLN4tYJ8GWwhlDhF3t85tw2BrSbFK5ACyFP
         QQDPaRv3dnm/3JbRjpDN1yRiHELd3KLxmO+F3sPE1aNgTuLgG5PSLlhQF7GYQMZdqS2D
         lbfw==
X-Gm-Message-State: AJIora9wMyY7nWy9NyYuaZy6sWSwu7dcQ76/sTWTwW9u5l/8UTgEpsKc
        dNlhj8nFObkbCrUFP8QpeMpjiqHil36EDi5J
X-Google-Smtp-Source: AGRyM1vAsw25xWmDPWaTpZqim2pT5kgw/MFKz+pCKh7uV8A1c/wMqM5nhOB/HHOpxMId0FtDZwls9w==
X-Received: by 2002:a05:600c:3b14:b0:3a2:de1d:fe0c with SMTP id m20-20020a05600c3b1400b003a2de1dfe0cmr799786wms.49.1657299715270;
        Fri, 08 Jul 2022 10:01:55 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id t5-20020adfe105000000b002103bd9c5acsm41336252wrz.105.2022.07.08.10.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 10:01:54 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     dmaengine@vger.kernel.org, Eugeniy.Paltsev@synopsys.com
Cc:     linux-kernel@vger.kernel.org, vkoul@kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: dw-axi-dmac updates (debug, minor bugfixes)
Date:   Fri,  8 Jul 2022 18:01:50 +0100
Message-Id: <20220708170153.269991-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

During some recent testing, it was useful to have a dump of the
registers during an channel dump and a couple of minor bugs were
found with issues where a slow response or race condition occured.


