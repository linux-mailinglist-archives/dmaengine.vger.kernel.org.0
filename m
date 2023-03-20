Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32686C112A
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 12:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCTLvE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 07:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjCTLvB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 07:51:01 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D841B22A0C
        for <dmaengine@vger.kernel.org>; Mon, 20 Mar 2023 04:50:59 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t11so14547080lfr.1
        for <dmaengine@vger.kernel.org>; Mon, 20 Mar 2023 04:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679313058;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=D1KDpNnEoprt+cJmcWiUNBAQS7hM0zbpS124hNBXPf32YLhrJjGuWrYBMaIi0FQ1Dq
         5TaY6WKvdIuji9XjNQNoCQCWo1SX+ruOy57x5/iq27/dHmvnXYGInJraffaI0Tqv3bo/
         xadeyWXWX/QqXnZYKvNM8HsGtvFse3V2KOSe+N9rMGS+DDVbF0vVuP9pE1NAag9rA2u9
         83aH//nJAAYvOUjUFx8pWxpw+viJ1X+RXSwrwZmcW+ZccR1t+tUfkPqWavrcjjuIsz9+
         SsyVYGGHF98N/h8Q0aTRcvE6DvYdD81+GPu2axTCdSStlEhxnT3qgo/Q1NHuIYvtd1V1
         sVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679313058;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=BySE7ZSXqryl6UIooJk9BN3FViv0HEhIARvOFg3bfpqiVkOCUyA8XNI6QGfRQb1+Yn
         H0gF0G2Xvp9TRB285eSOVtECb/V4ukIzI66g6hEiU2FjenHnwVgpj1KpOSU+4XqIMh+O
         2mi3PLoVnz2RZ8j3PnQCq3GcTI0HV7u7VtZ9dPV0gvVDRBa8cdShH0yvEdz9zZ+Wxq7J
         pHMfJXyUj46J2LSnbuEG3Vpf11aQmktfL9ns60ZTJuGPMOvRVKn1zticDQqdYGXSjPwu
         zj+A7XQszkx4jTP7Ywhmz9pg5rkSeLDfS2NvOgcUThImdXR0D+GnuNBkF8G4U4J5W4l/
         x7uw==
X-Gm-Message-State: AO0yUKVJmSON63x5yGFCstH5TA4aZmUgC0oecHLUha+hku5KpkXULelZ
        WjYxGau3Aqlwn+ewannZyifGD1GzIAj0kDJgG2g=
X-Google-Smtp-Source: AK7set94cgOWtQE8ieKUq6JBnuYZHJRTfthOzPOakSvTtZ6I6GcBv8w8BpZIAmqMwgis9Dc8gCCLQsO6KXrHwURjX50=
X-Received: by 2002:a05:6512:38cf:b0:4dd:9931:c4ee with SMTP id
 p15-20020a05651238cf00b004dd9931c4eemr7026845lft.12.1679313058064; Mon, 20
 Mar 2023 04:50:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:73ca:0:b0:222:5939:ed00 with HTTP; Mon, 20 Mar 2023
 04:50:57 -0700 (PDT)
Reply-To: contact.ninacoulibaly@inbox.eu
From:   nina coulibaly <ninacoulibaly214@gmail.com>
Date:   Mon, 20 Mar 2023 04:50:57 -0700
Message-ID: <CAL5O4-FtLU8_MHS-zY-RPYMrr1b+ozH9A6eyJBuwZYtF2e3hAg@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Dear,

I am interested to invest with you in your country with total trust
and i hope you will give me total support, sincerity and commitment.
Please get back to me as soon as possible so that i can give you my
proposed details of funding and others.

Best Regards.

Mrs Nina Coulibaly
