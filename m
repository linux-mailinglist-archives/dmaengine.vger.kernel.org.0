Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239D665D22F
	for <lists+dmaengine@lfdr.de>; Wed,  4 Jan 2023 13:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjADMQB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Jan 2023 07:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjADMP7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Jan 2023 07:15:59 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B64F5AA
        for <dmaengine@vger.kernel.org>; Wed,  4 Jan 2023 04:15:55 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id f34so50071715lfv.10
        for <dmaengine@vger.kernel.org>; Wed, 04 Jan 2023 04:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2m/uNsCm/OsAUZxAnJOSdXXDa9Gh4wg88n4VPL2lMU=;
        b=aM07Bn6JQqzPEUQ+jdoFJwK8pPq8Sk//vhdCKzTg7+to/jhNzLMPMkgk14TX8begZW
         lt8AUhmVQ2PR635sdg2D/uezZkwRz379iVzQwmWIJLF57F7Vn8wl5roEKmaIMCpBtu93
         +RB0cMhISlCiZRKEipAaPbPHX25TY0RNP1jyoLMdO85lrKb6thp9jZb9HOk5ncekCIan
         xv3xwy5bZZhDC73tNSuZP3cdbAOEjRsmoFWnxqte9fXJqrR1lxzJP7QPsG6NAd6rSAEj
         wzx/H5I2Ty2FVffMPNM9ZDH8aPy1DxBbdEKLHi4rWmCv4P+PDC3r7I3Hq8ApEGApckr/
         qY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2m/uNsCm/OsAUZxAnJOSdXXDa9Gh4wg88n4VPL2lMU=;
        b=QGP7uQ1GqEBjez4KYjjZftjm0FrO/yWRf5v5Nmrp5bzGitixPlaY7fH+dkCMdhUEIq
         pYjorGqSYv38E67T3JWqXDQHd/CyfsgJN8sUQM+hauYiyQZgCzpe8bCV+/L4Ei0cJw1B
         LvAfQ8Zy/8NmdEBsntwbJboa91u75QGeXD3Wip75NKVKHzSBfHRYmY6WcFo4nhFY2n8Y
         kMbYEKFwaIXzw6Elmg89xSEaVjfYxg9lAy0bn5wE//JQnt36TJj1BMkEegRNuyV4kbWL
         /deWWJxwk+SalPd70iZKnPZsiNv893AYtfAKbjspxc4ADGBJifrmvYy1w1cb9NJbYsh8
         KFXg==
X-Gm-Message-State: AFqh2kp3ci1iNgQFllwiCpwxOAvOgq6UG5mT5hY7/xabVrSmZgINFL4P
        jHZtAllX3DWvEqfNtXRWpKkwN82le6V1G9M65j9Z1pYi1sA=
X-Google-Smtp-Source: AMrXdXuOf5pxxoJXfsUV9tQ2NJOFT7wfNXQRO2Ss57Xm+8vHU0XgVHqFWDC/D1eGd9SFMKbOvlNJ65CGWvodlfnqKBc=
X-Received: by 2002:a05:6512:23a9:b0:4bb:70b2:6f4a with SMTP id
 c41-20020a05651223a900b004bb70b26f4amr5380273lfv.1.1672834542928; Wed, 04 Jan
 2023 04:15:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6520:2191:b0:23b:e463:204d with HTTP; Wed, 4 Jan 2023
 04:15:42 -0800 (PST)
Reply-To: gregdenzell9@gmail.com
From:   Greg Denzell <denzellg74@gmail.com>
Date:   Wed, 4 Jan 2023 12:15:42 +0000
Message-ID: <CAMLOHgP==yVaiq2+kQTMwnjk9RePyV2BBvoZYcxvS_epzb5gcw@mail.gmail.com>
Subject: Seasons Greetings!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Seasons Greetings!

This will remind you again that I have not yet received your reply to
my last message to you.
