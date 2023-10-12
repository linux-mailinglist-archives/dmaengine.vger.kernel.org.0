Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08F57C718E
	for <lists+dmaengine@lfdr.de>; Thu, 12 Oct 2023 17:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjJLPdO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Oct 2023 11:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbjJLPdN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 Oct 2023 11:33:13 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BECCC
        for <dmaengine@vger.kernel.org>; Thu, 12 Oct 2023 08:33:11 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 5b1f17b1804b1-405524e6768so11806135e9.2
        for <dmaengine@vger.kernel.org>; Thu, 12 Oct 2023 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697124789; x=1697729589; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fLM7r5s+rbyDn6QetnyuT0oGLsDfbMJhPIHwI7YSStQ=;
        b=BzgggNvx0ZiSwV97PZ/psK4zsuEtC02Naw5BztTyn75IliNndjKeJohwcxtsy2JPVi
         5LGdV46WpG5bpnYV/YvPZ5Jr7OGjVPU2ctEd061HPkMlWPlWz7urDkou3hywXC80KO1y
         YEuyGKOTGjauGPaSmrVO2zx7MJcYtRRs5TRUMCWt/2JWKw7bN1ug5esqbVt713icWMGg
         K+47fewXiwgb5HWIbTZFSOUIFBiMnOUy/Ua0rwpjdytAksJH5w4I93F1iBqGzSbdd6B3
         PrDEiGXvTAgOtRjLY+r2UvNcSY7H2i4mBuLwZeJM4Uz0rS9V/6HaxBmtEW7FIW/5ZfDS
         pRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697124789; x=1697729589;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLM7r5s+rbyDn6QetnyuT0oGLsDfbMJhPIHwI7YSStQ=;
        b=W+LjlDpZe3oLqn8BElSQceyyInUUhjdMV1gRrwm7+2aBBpe69dR49dNy/HCYXrDsx7
         F5sVv6kj9a+g6y83NWAHdHZXe9GpuxkoB64zlkzGUGxmh90UzHeIzT3f1pJ7jbRg6P8D
         iTURYJU8qXIV9yshaA5TEnKA9asXWAdjD6W0ugeB97mej99AtdGACV4GrEryBmxChXqH
         1egHopgeMkBJ8EgvtAwF5bFbujKaM97XS7YbzhJWris5q5/4XRQ0R/48+nGIiCjma7/2
         ZENNQ0snUBmwhCkb1djEcsXRRAIO4Me0DzXrZBNvosQ4T1++05gSZRVNermJnY4Edd0r
         gHXQ==
X-Gm-Message-State: AOJu0YwOGpU9q1ETins+4vbaz5SLU2T60FK4bLrcCP6Mg1blBukVkVq4
        ibxxSC8Yw/MH2QU0nflxq03+HIgngIEofpJY/Ks=
X-Google-Smtp-Source: AGHT+IHv4ZB7NC2zVd/zhtCrlUjhcyqtzsM4zZ0aMc3GL98J+1XioWDFBiGS2gU9J2LCBHyJkmXI4aQDPRKbhpzrY7o=
X-Received: by 2002:adf:fc4c:0:b0:319:785a:fce0 with SMTP id
 e12-20020adffc4c000000b00319785afce0mr21667195wrs.26.1697124789485; Thu, 12
 Oct 2023 08:33:09 -0700 (PDT)
MIME-Version: 1.0
From:   George Lee <onlinemarketlist6@gmail.com>
Date:   Thu, 12 Oct 2023 10:32:41 -0500
Message-ID: <CAHeUWaYJ4=EJ_KChoUdedXfA5f7A64AsTG3u-U=JKFXe01LMNA@mail.gmail.com>
Subject: RE: MJBizCon Attendees Email List- 2023
To:     George Lee <onlinemarketlist6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

I hope you and your family are safe!

Would you be interested in acquiring MJBizCon Conference Attendees
Data List-2023?

Each Contact Includes: - Org Name, First Name. Contact Job Title,
Verified Email Address, Website URL, Mailing Address, Phone Number,
Fax Number, Industry and many more=E2=80=A6

Number of Contacts: - 10,653
Cost: - $1,479

Appreciate your time and I look forward to hearing from you.

Kind Regards,
George
Marketing Coordinator
