Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243E64D7062
	for <lists+dmaengine@lfdr.de>; Sat, 12 Mar 2022 19:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiCLSU4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 12 Mar 2022 13:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiCLSU4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 12 Mar 2022 13:20:56 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B943F39697
        for <dmaengine@vger.kernel.org>; Sat, 12 Mar 2022 10:19:50 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id q11so13717419iod.6
        for <dmaengine@vger.kernel.org>; Sat, 12 Mar 2022 10:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=KXMxTSuYMoI2m9PjGelUxJue4FLetlZ7vJOnZ1VDEz4HJ9+HORnmeytX0ZAHb7WHYn
         qGwfxLG2TDgdBY7JkavRcrmAz6HQLrPlMYx3f7H/9oTdkK6X5JwGvMISc3J8WTSscn/z
         9SpsoRmpDwaaIQR9t/pRcFwbKJFlHUHLyD1AY3SghMmlUh/JI9wj3WDFa2RZrD1ah84S
         da7YWAiT/g9PjtwIcCi23j5qhWqcLK9Pi20cdqTOuISBbS1g2gT40Z4T7jVKllL2lFp0
         8SbETwSdYUdV0L9jcwfyLahBrDDwqMHbq31TOZbdOXN+I9hTrjJhbCGl0uPIbGeA2H4c
         hF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=K/DguxcVht8xA83aV2RzTwyR/8sp5sFgltl6uUkYvocJxU2oXIPnM8BlWmJQ+CkXV/
         OVEgSTzmwWzTJ0ShlefzwM+0SdStmT8VPKDbGPX4F4VL02d0DNWVMC4HlP7OHBWgzkB0
         sDL7zT6KR9aFky/pMx5dSSMKLK2wwNTriJgxU7W7kO8Ted6VTcWd/p75OOTFzPwfxBO+
         Jv13l3tGBT5L3Ev2d8PLDgqQXr5tJm+b33+sOSbsGfVpL/0Gz+1WZ6OheWAATwvUmEfo
         gvMPCRBRH3uP2JmUdQ0nN/d/fHKsooX4W4sR5hZ3Svsm48EgwE0PCnFQz31IIF6OB9if
         cqow==
X-Gm-Message-State: AOAM531YKpiNkNyehT7V78puP7a2WFH20YzVphvG4Ewcyx6TMK2FOpfv
        zd1Rfg8gN7y5Xwpqo/CR9/9OfEkBMip7Aldf3yU=
X-Google-Smtp-Source: ABdhPJxMegqd/Tb9AS4zHd7Pm7tMIApqmZ86KznKDzQc2Nw+zaKI8WFI6vYRHG2CLK3MPG8oJ2VFCgFkoXm1ajuNERk=
X-Received: by 2002:a02:cc54:0:b0:317:c406:614b with SMTP id
 i20-20020a02cc54000000b00317c406614bmr13055759jaq.149.1647109189713; Sat, 12
 Mar 2022 10:19:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6622:3207:0:0:0:0 with HTTP; Sat, 12 Mar 2022 10:19:49
 -0800 (PST)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <mariam120jamila@gmail.com>
Date:   Sat, 12 Mar 2022 10:19:49 -0800
Message-ID: <CAMBTtffJ7Pby4OYSGQ7ks9rgrdB_RFjeTgiYS_h2u1EsjO82kw@mail.gmail.com>
Subject: From Dr Ava Smith from United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
