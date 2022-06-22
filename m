Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4A2554E35
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 17:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355987AbiFVPCO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 11:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357989AbiFVPCF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 11:02:05 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54793D1FA
        for <dmaengine@vger.kernel.org>; Wed, 22 Jun 2022 08:02:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id a17so13661647pls.6
        for <dmaengine@vger.kernel.org>; Wed, 22 Jun 2022 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=vhZEVnaGNBjosB86GDUW8b2wHjB/+QU31bPXl36TqFE=;
        b=bOIblDT7+P2BBNypX05Nisr9+JiNO30n5N0+Z8TsF8G8ewS1QQZ2blbKxZ3afwl4rb
         Y1R7WjL0nQm22vyflOQhEeZFDRruhD2rMxeOQYEfpEV7tW8n/ju9SzNMyVgL9BE26Vgd
         FPoyWluWkn5NNuhlxGiavmntWuTzVXfRo77wVsa62cPMStB3JdJrYD+wkVfiN1rNOqNf
         ZyyclRAod0inNVFoU0jnQ0MB+3irBDVq0/iOt9ZwHBKVlY6XDu+4VLY2EYKpkm1k7EVM
         ihzj2OoXiiZzbOIYCo0kkkYO8bFuNsaV/VkYkiSxlxuYsSK8SV65II48K4y9ptx1O0B4
         3BVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=vhZEVnaGNBjosB86GDUW8b2wHjB/+QU31bPXl36TqFE=;
        b=BtiDDYKaasx7hzT5Hz5Y9zv0iL1UCbgIfR4Bblvxa5yg8tebUQAtT1inYggpI4nWCv
         NROxjpKectv0sd/r873Y4eFgXW+uZyhVqvgAqKz2KFDQ9GBg8XxzZ2V8hX/C6TF3j2W7
         oZuwR9ufiM4ZstAP1FizERoHyFHxp/JmgN341G2j8MawrDGp8cz7SFkaTd7/IvJt173J
         2tr/E4pCdjUkW5oPyUtsN6zxJc+sX1v5EHnz5VVyr367otilpA9SdhO3gF/YHFFkytgv
         g+zS5yfpMgwtMKG+xcDN3F/jary2Lxq01xmQoJ34hsE8ENXXnHuIhQw8FHl7zNwv6GK1
         OC3w==
X-Gm-Message-State: AJIora/X40wvm3UGWI1evLTvtltSVT1CGkjFKW5EcOlPjjwlR3a6CfPC
        mn0NOIah9au3bzpxI8m3ZxgMlBSg5djMrVv0UG0=
X-Google-Smtp-Source: AGRyM1toIig5ko4X91q4CAxDqQnZnwtT8qlWTs7GRjU3136Ss298ySYrx9golUZ8IsMMwX5SjEXNFGkkdWK3GEMPZ/M=
X-Received: by 2002:a17:903:2cf:b0:151:a932:f1f0 with SMTP id
 s15-20020a17090302cf00b00151a932f1f0mr34621367plk.130.1655910123205; Wed, 22
 Jun 2022 08:02:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:903:2308:b0:16a:1b3f:f74b with HTTP; Wed, 22 Jun 2022
 08:02:02 -0700 (PDT)
Reply-To: sales0212@asonmedsystemsinc.com
From:   Prasad Ronni <lerwickfinance7@gmail.com>
Date:   Wed, 22 Jun 2022 16:02:02 +0100
Message-ID: <CAFkto5u=T4juAX=CPEE_uD2VPgpXudytrSqLxDGkEyhnZpoy8Q@mail.gmail.com>
Subject: Service Needed.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

-- 
Hi,

Are you currently open to work as our executive company representative
on contractual basis working remotely? If yes, we will be happy to
share more details. Looking forward to your response.

Regards,
