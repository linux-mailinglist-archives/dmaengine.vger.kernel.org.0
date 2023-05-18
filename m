Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B83707B24
	for <lists+dmaengine@lfdr.de>; Thu, 18 May 2023 09:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjERHhb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 May 2023 03:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjERHh2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 May 2023 03:37:28 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F8AEE
        for <dmaengine@vger.kernel.org>; Thu, 18 May 2023 00:37:27 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2ac770a99e2so18568041fa.3
        for <dmaengine@vger.kernel.org>; Thu, 18 May 2023 00:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684395446; x=1686987446;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=OJVwuF8bZTXSArvsCO6TmDvEmSazfmGzstlGRZQz2YbwfTiyOBVBXydU0WzyShqbLp
         gk5iTU/n2mqGXUAqy19mr146rKPQePovmWa/mURxle8jlDxUxj6n11PcjI8AukTicu17
         Ylw5Yd0GYQvbvUmcw0+2PJi2Jn8sKMBUGl3oHEkcdKQZ+7x7HPwtNsu6awbTa3sMqTl9
         0h5AGCV256lUZUy4vcejxJg9uNvJnZEEvYOFTtMR3UyKBZOsuGDY5EBY0WGFwARhVCq8
         hKE9K26b1CKcPbVlWu68s4V8YvVf53L8tv8+VL9qmTB0maDMjgewMOlnzDJFpaW9NcSj
         4nWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684395446; x=1686987446;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=XCIJTjZG1fhQXyEJzSdKLJBx/SC9fi4Usiqya2AL0Th4ZYdBDpeaMMbER8hMxMnc6V
         KeXkcYM8Mm1HSf0919Xxdv2q2k78nJfYqbmrPoViP0PbsfSOXkvpa+gp61e6MvanB8Sg
         tfARIOWccj5z76uXwTBhJq4ngYTmAcI5dgnvGLhnrzOu5RdCZstVp+vrGubhujL57or4
         +HfDjWLE2GW+zYyHec9l+aNq+NFR0AiEuixZ+nC4J5TxTV04XcT46UNVApi44gR2aMVd
         dgOmlnhW91IKVS2KtcN4uANEQWyclawMHnwHLpKUq9SKfMrUHxuwdDrxQAXUL/oea0pV
         rPTA==
X-Gm-Message-State: AC+VfDyU25MW3GvoWdmG8EUqezHy01NKHj5SIMAgxgPo7ONkEVuesXev
        WVX3m3TkreAv+0iQJG5hThrvnq/oIIhSOw22X0I=
X-Google-Smtp-Source: ACHHUZ4bJx7KXZCcm8MTyxKapRa3FqPpYKfvdgb7rlaaHYKTlFdLJb5/mI/IMCq6dO3QO8p2ExanAI/S58rjWc4LzKQ=
X-Received: by 2002:a2e:6e05:0:b0:2a8:a858:a4ab with SMTP id
 j5-20020a2e6e05000000b002a8a858a4abmr10396243ljc.39.1684395445797; Thu, 18
 May 2023 00:37:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:7310:0:b0:222:5939:ed00 with HTTP; Thu, 18 May 2023
 00:37:25 -0700 (PDT)
Reply-To: contact.ninacoulibaly@inbox.eu
From:   nina coulibaly <ninacoulibaly214@gmail.com>
Date:   Thu, 18 May 2023 00:37:25 -0700
Message-ID: <CAL5O4-GY=nDF+of7cRw+wHfT9fc2Tp1C=aTpmHdrnBp0NDO6SQ@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
