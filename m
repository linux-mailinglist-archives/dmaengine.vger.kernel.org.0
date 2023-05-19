Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117B5709230
	for <lists+dmaengine@lfdr.de>; Fri, 19 May 2023 10:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjESIxa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 May 2023 04:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjESIx3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 19 May 2023 04:53:29 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632E01994
        for <dmaengine@vger.kernel.org>; Fri, 19 May 2023 01:52:59 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b9246a5f3feso5019628276.1
        for <dmaengine@vger.kernel.org>; Fri, 19 May 2023 01:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684486378; x=1687078378;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9VGGyuCCLKSSiQdC0nI1d1YAaPWI1/GKqon17Q9aHQ=;
        b=lb7EDu23zlszfvgNQcRdozhkXbSRKv609dCLXyLS7pt9D3WtnkUfCNMJb1M+ow4O1z
         KabMaukUZyr1RCKHeArb7V/9o9nMT1uGzstbzOqOWg8t5ECj3Wqlk/ui+MxAyrr4vab+
         tnr1OzkqdVKaAdputlzapkAxeyC8QHdqbghR9LXdrx2ApJWyYa3l7sPHsTyZd1EK3uS/
         96iDKrZPXztx4MOvRSJBq0DYX10tLX4mcklVKkvaeDXDo3h6kIyYXRUWsJp3ckkNW6V4
         MXZDdbtSuAOa4UWjdeKo634drE6bQL7TxC+IIo+wzn78qEqz9D3ilGTffr65/OfdukbP
         hdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684486378; x=1687078378;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9VGGyuCCLKSSiQdC0nI1d1YAaPWI1/GKqon17Q9aHQ=;
        b=R5mIzpr53Pghfrkrp11GOhnRwWSEZfaqTjPiPCUPG1UM0hk4RlXbMooDxQ2Lp4TWzg
         s51k4kZnkxJ1xtKu/TrjfSEJZwGtXrwj4L3xUKPCHnAQlNxTvvqgDD9tk/hruS4BFLJi
         RJ8NNVxKDyYDNpUPJ1tPL4L9qWv0PxkZBhbv3at/l/67lCdpO+gqsxG/nDPfUy5JAYxy
         BgHkODrJ1Rsl7HUA14JmhsdvVCIqc3mxgwbvj4i1vMgZfC8Qf4WA/is4CRy519DZhcZh
         c4Xf5qBltiotWXHvOMzNShxKF9xNkE9JIHniUybF8h0Vco0qi8N5zvnd8VLSz0lbUBi5
         NPBQ==
X-Gm-Message-State: AC+VfDzCIfiPeVx7zoBvbovvN/5/hMjbo2phoCMBsdI19dymWCcdpy/y
        LbsdxERieM0ACL+OVnJsh0/TfO3yEs1iBrQks1c=
X-Google-Smtp-Source: ACHHUZ48zOHJWBHHpgUpwj9CidupuVxAEqesGV7v5CTWYEerlUF3o0oYFf4a+PMOiGi9gRqkpour3H12pWiWSEnK5YM=
X-Received: by 2002:a05:6902:1101:b0:ba7:3df3:6df5 with SMTP id
 o1-20020a056902110100b00ba73df36df5mr1248052ybu.38.1684486378377; Fri, 19 May
 2023 01:52:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:6108:b0:2fa:ea06:e64c with HTTP; Fri, 19 May 2023
 01:52:58 -0700 (PDT)
Reply-To: ninacoulibaly03@hotmail.com
From:   nina coulibaly <ninacoulibaly01@gmail.com>
Date:   Fri, 19 May 2023 01:52:58 -0700
Message-ID: <CALav4vTjkujsC1rMBX1tsvG10RUSH6HEvnz1b+9zt_aoVOKsbg@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Dear

Please grant me permission to share a very crucial discussion with
you. I am looking forward to hearing from you at your earliest
convenience.

Mrs. Nina Coulibaly
