Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D1E5EBFA3
	for <lists+dmaengine@lfdr.de>; Tue, 27 Sep 2022 12:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiI0KXK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Sep 2022 06:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiI0KXJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Sep 2022 06:23:09 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A70D33E8
        for <dmaengine@vger.kernel.org>; Tue, 27 Sep 2022 03:23:08 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id i17so392069ioa.13
        for <dmaengine@vger.kernel.org>; Tue, 27 Sep 2022 03:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=oLr60vtiCFi1SKgOOBjNqFq00HF4tMgYoa3KMAS1Q7Q=;
        b=gY2V41+FisE8yWdfjST3yw33aREYKKP8ktYbkxm8j2Uxpj6T9MrDTvF+6uejKZxOs1
         FWRZeddfe2NFUhSROeZLXeNEMeFuE84AJIFyG5GOllXzeSm0ZguC7CXHnAqhzlEj8lPc
         BwvfX8ErtTH+rpb3BlXDhEEaTqoRXZOK4PRRb+qPyXB2VnKxESUdQyRMoQ5JQL6S0cWA
         hQEqHCxu/xgkKuvXKOVymGn2vsNGJHBUHn73vArWu1Y8Y/BizYCtTTvAkTcDHmT0iXba
         v8rwi0tmIsv05HJnCXRMqi7jmmmZjgAA8jvNszXM68M4dQ+5npDksh3rt6ybJKtdrJP3
         R3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oLr60vtiCFi1SKgOOBjNqFq00HF4tMgYoa3KMAS1Q7Q=;
        b=YjCLRoqwmFEFuuYm2p+Lwa0T2Z2DAXo15PO186HYNKsiRAocY0NG7keRvsQfabQ5QG
         tNtcVkEmdgYIel8IplT+5yWmA4E7KHzPO+CWBqaRRf9n4UrBIps0irxPmX2dRYsFYsIj
         fOgYGk4TYIu9a5zsJ4DatPkbGhpv1fF83LlSoLecALE5Nx4flnwIBZXfHY86WTmrHy5M
         EL1Rewj+MKOKd/HxlskqikVPkKA0ynQU3ICc2BD+c8oUG+p0sDqBjrKv7i4kFPADsZZu
         dDJ1Q9O2IJSRxXHKBlCGQeugQZiXbEz5VSRzdIEE2Y3G2cgOVih6wmTsuBU/aemtNzOU
         txHQ==
X-Gm-Message-State: ACrzQf3A45zJBjwZD4GdSX7bwSxVdO/c5S6GiaHrtUyfQzc8XzZMbhWj
        ULv+WqYiss/E847XJT5btV1Oly69yxOuEpUPqPU=
X-Google-Smtp-Source: AMsMyM6hRNHp4B0ncoBr88ZawvlX12tpCXz+ju9ri5EIuk2aTqjL8+nc8kDu8ccb69F/yrLXZyJ2w0/Rwff1M3P554g=
X-Received: by 2002:a02:c6c6:0:b0:359:b2d9:8838 with SMTP id
 r6-20020a02c6c6000000b00359b2d98838mr14577394jan.298.1664274186865; Tue, 27
 Sep 2022 03:23:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:32a8:0:0:0:0 with HTTP; Tue, 27 Sep 2022 03:23:06
 -0700 (PDT)
Reply-To: nn9122250@gmail.com
From:   "Mr.K.Mashal" <michealibe122@gmail.com>
Date:   Tue, 27 Sep 2022 03:23:06 -0700
Message-ID: <CAMciPd9OFtaM2ajy2iBTUCXUg6iZhF_ieyUAufmjY5Gu8aT3aw@mail.gmail.com>
Subject: Reliable Business Concept
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_50,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d36 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [nn9122250[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [michealibe122[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [michealibe122[at]gmail.com]
        *  2.0 DEAR_SOMETHING BODY: Contains 'Dear (something)'
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Dear Sir,

Vital business opportunity in my position Interested kindly contact me
for more details:dalh52179@gmail.com

   Regards

Mr.K.Mashal.
dalh52179@gmail.com
