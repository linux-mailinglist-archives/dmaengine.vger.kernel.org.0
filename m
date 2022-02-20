Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62A74BCE7F
	for <lists+dmaengine@lfdr.de>; Sun, 20 Feb 2022 13:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbiBTMpc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 20 Feb 2022 07:45:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbiBTMpc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 20 Feb 2022 07:45:32 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8640932EF1
        for <dmaengine@vger.kernel.org>; Sun, 20 Feb 2022 04:45:11 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id i14so22366519wrc.10
        for <dmaengine@vger.kernel.org>; Sun, 20 Feb 2022 04:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=T28r8IcApmahqshNb89Vq7Sss5daNXvHX2RvLjpVFBs=;
        b=pKQO6JlKP1IWsu0Sgd2LGN/UNs3bUPt6TYDUM8F3CWmvV8j6+5S7MeoIiR+GDiA+BU
         fA1FJiVbuFO1pX+qV1tDFtu8p+LPrr4bO1QNsvRtB3PtUOP5n0WyxSmyJFa2muHb0/8x
         KpKzVPPglU7u7HbqM0FqYMhYRrzDfXoWBahELht+MGT42zY+OkrwOqLjK4ew1t0fHUEn
         JQ3Kn2w1vb3xb1s0NpUxB57uY8hd7YbmKwHuHr9Fmvf1cVLo8kzl23cj6ykNq4R0qoiG
         J3LYboEmsKJuzVNmDbA0FSy6O7dONQ24GhDUR4mQToMraU2qH9dinoSrMPQ2SL9NlWbw
         1lQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=T28r8IcApmahqshNb89Vq7Sss5daNXvHX2RvLjpVFBs=;
        b=R/oOmKfcB4ZXCwE9XfQFPK3ra7qxuDCPiPjzGgP27aCWwkcvb6hksF2BhurhYl6Ius
         vqcwepYPCDq3To7jyc7cOHMoWn4EPkcFLvcuN7M3ZNg6RwXdSx56yMZpe2WatT00mJH/
         iMLQAQ3XiTOUdetVWnYPtgLu7L29K5XE8RE1YFRQLRtWi+3R8ldy/2FuV/7MUqSfV8/3
         +b9cU14V/Zk7eaUXIuEh6vvaP2RYHyVOdw+lp266hc5ryalLB4WMt1TtKhdgvpqBgx72
         Uz7ItfB2i2+sQ0Q+DTgO6OiKH8mFrwoKpwyN6sVEw9BOgIe2XH7I0eJOlxL3hTisXnyc
         K/eA==
X-Gm-Message-State: AOAM531v8/swmJvDw/AlPHcZHaD75IfgiCyhNv6K+6ZIALuKiGq8XKWW
        Qoe34Ol6pTmnPFhOA9u7OSE=
X-Google-Smtp-Source: ABdhPJwmoNayQgEdTQQ5iPstaPcGELur8YOjPWOi9ICtP4CUjWl/PlTzbHU1lsxKFO44HxiffvN1jg==
X-Received: by 2002:a5d:680c:0:b0:1e4:2d98:46fe with SMTP id w12-20020a5d680c000000b001e42d9846femr12644118wru.411.1645361110095;
        Sun, 20 Feb 2022 04:45:10 -0800 (PST)
Received: from [192.168.0.133] ([5.193.8.34])
        by smtp.gmail.com with ESMTPSA id d29sm12032201wra.63.2022.02.20.04.45.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 20 Feb 2022 04:45:09 -0800 (PST)
Message-ID: <621237d5.1c69fb81.403ca.b065@mx.google.com>
From:   Mrs Maria Elisabeth Schaeffler <loganethan51@gmail.com>
X-Google-Original-From: Mrs Maria Elisabeth Schaeffler
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Spende
To:     Recipients <Mrs@vger.kernel.org>
Date:   Sun, 20 Feb 2022 16:45:03 +0400
Reply-To: mariaeisaeth001@gmail.com
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,TO_MALFORMED,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hallo, =


Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Wirtschaftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen, die restlichen 25% dieses Ja=
hr 2022 an Einzelpersonen zu verschenken. Ich habe mich entschlossen, Ihnen=
 1.500.000,00 Euro zu spenden. Wenn Sie an meiner Spende interessiert sind,=
 kontaktieren Sie mich bitte f=FCr weitere Informationen.

Sie k=F6nnen auch =FCber den folgenden Link mehr =FCber mich lesen
https://en.wikipedia.org/wiki/Maria-Elisabeth_Schaeffler

Gr=FC=DFe
Gesch=E4ftsf=FChrer Wipro Limited
Maria-Elisabeth_Schaeffler
E-Mail: mariaeisaeth001@gmail.com
