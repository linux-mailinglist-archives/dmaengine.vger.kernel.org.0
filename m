Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0BA642CB3
	for <lists+dmaengine@lfdr.de>; Mon,  5 Dec 2022 17:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiLEQWR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Dec 2022 11:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiLEQWQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Dec 2022 11:22:16 -0500
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB1B1DA5C
        for <dmaengine@vger.kernel.org>; Mon,  5 Dec 2022 08:22:15 -0800 (PST)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-1441d7d40c6so14010004fac.8
        for <dmaengine@vger.kernel.org>; Mon, 05 Dec 2022 08:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O4WPtqOs6pYDke8VCfpzwsIX+8zN33o8tLS2XMy/lFU=;
        b=KxbjfurGgJ6WXlbx6ya1CGUl/fUka4xc7idppF/2xbPAyVXLdrvx4Pi5XPQFgjjlbo
         iazzUK8dhCf/oe3UtTYfhmmJkcrS2wIqN6md3NvrtRyWwdCLXG40VTDRaA4eTTR7+L72
         4iiXiyn733T/oOS/apNbZoh5LO2S2K+RySAcIVp1bkriNN6qD9nH4/yg6RBFiQlkLcwm
         LOSAwTA6iSxv0NfPnLrV7/+uhknd1zTx95luRdiTCQpzn6Vv9mLBeRhdlPn3NkXnbVzS
         3XBXY0tleE+h4dlCL87pq1THJItTS4vvbwa9kwzRjUSSJnqPVODHUwhp4luMByDMStrK
         knTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4WPtqOs6pYDke8VCfpzwsIX+8zN33o8tLS2XMy/lFU=;
        b=MCUX5KtzX7RN/9HXzkUhqHqaHfperdLiV4k/SEF2vY74Xvq2lWx2LU7Nj140qhRelv
         UqU0df0SvKcj82uLT49cxSxo42MURS6SXzEKxkUordaa/UzEiB02pD1lYJgnECQLQMoQ
         mc+uQ3GCmo9tFctsfcNMHsgBL6ghDCYDL3Wh9tMVEwgWA13/FYAiyA5unY2guuuipO+B
         FFG9as6vC+RV7OwJVHBQ48o73MiRHdePQPSJcmBUURDJ5ciF79zCG9I+QlO6waJYrxSY
         Uh692KQjHWMn5Elo/2DuFtToDaeuMaQaQ1T2wuhUjVO2vpSnxcKhiaz2WWZvN/PZU+uV
         ksog==
X-Gm-Message-State: ANoB5pk+39ma5zi/jZr2yVIVjiSBnpoSnzfFJTbVCmhQc4V1TCYqs1nz
        6RTGxZb0rR6VrynEm/sZZIrdUb+XWKLwttC8+kU=
X-Google-Smtp-Source: AA0mqf7Jo3W5wa33TXcTw3+MFOe7IitpYWG/TZ8fljx832V7dtHEFG3NwI8mUyUY9ZBbz8v8Ow9bwLX6NjPHyiaCHfw=
X-Received: by 2002:a05:6870:d608:b0:144:b4d9:4a37 with SMTP id
 a8-20020a056870d60800b00144b4d94a37mr1229607oaq.117.1670257335118; Mon, 05
 Dec 2022 08:22:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6870:5ccc:b0:143:84e0:abae with HTTP; Mon, 5 Dec 2022
 08:22:14 -0800 (PST)
Reply-To: phmanu212@hotmail.com
From:   Philip Manul <phmanu005@gmail.com>
Date:   Mon, 5 Dec 2022 08:22:14 -0800
Message-ID: <CAFKg=dZjfMXyc8vC=5c3qraFsZ9AnYbiX0+BhBQswJ4HnwOmOA@mail.gmail.com>
Subject: REP:
To:     in <in@proposal.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

--=20
Guten tag,
Mein Name ist Philip Manul. Ich bin von Beruf Rechtsanwalt. Ich habe
einen verstorbenen Kunden, der zuf=C3=A4llig denselben Namen mit Ihnen
teilt. Ich habe alle Papierdokumente in meinem Besitz. Ihr Verwandter,
mein verstorbener Kunde, hat hier in meinem Land einen nicht
beanspruchten Fonds zur=C3=BCckgelassen. Ich warte auf Ihre Antwort zum
Verfahren.
Philip Manul.
