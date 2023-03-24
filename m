Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A176C7CAD
	for <lists+dmaengine@lfdr.de>; Fri, 24 Mar 2023 11:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjCXKct (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Mar 2023 06:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjCXKcW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Mar 2023 06:32:22 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B782821F
        for <dmaengine@vger.kernel.org>; Fri, 24 Mar 2023 03:32:12 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id kc4so1397129plb.10
        for <dmaengine@vger.kernel.org>; Fri, 24 Mar 2023 03:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infob2bdata-com.20210112.gappssmtp.com; s=20210112; t=1679653932;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JZZlnKmbmBD1jDe56IEbjyrsVjOvBUMRvr7A3bLP7AY=;
        b=ZSdicG3tfpGCjXQy0NX41pciRNsZ6jQJ3nxJ+p5YGMRvd0wNQPHgrv07otOqjRWAtK
         gQXkVnO2PM92o9LWDqseVNoBZ404MKos8+A+lUyqjV3Us7krlBk1OksUU01Nb7MnWbPc
         y7IZzZ5LjZFPuBwykPiIPShIhQ5nowKKAMgVvZ/nQn4AgQIA41gYtSbPs7I60Voygj3E
         ZeX7FeeOU25gpOhgb5aaem0ckqQdmEodoKdgPP+Y5PKcNYLkelF/VlkVc+pBxFSYrEKp
         412aqNJ4d1ihjFt+QDj9fxm76ADNZR1ib7bTYnGYgVF/oBNf+943tWUjBtA+JCcExs0/
         z+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679653932;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZZlnKmbmBD1jDe56IEbjyrsVjOvBUMRvr7A3bLP7AY=;
        b=b1TdCqPX8lM04IsEMB/sB3PsUHC+2EV2vhXaaTSqONzUC/6YlHQT1uISLk5eiVfpQx
         orE5+k9AEZZU/gAh7SCbXARywyAXqvDcPKJ/q0Lo3caV8HKyNSh7z0u0DZ+Q69BeCxcV
         /aEEFva8AGpocoKoMcAvrJSqeeQKpwopaxXL3YLetCeNRk7iB2tRgJ3Bp6uoK97IBWFm
         4vvHJn3RvN51PB5edzx2hLbm9nxLbIKz7O4TqAXXtMpRXVsPF+ubJnQZLkPdlt3u+Ii4
         +G3Bs4RJ3G/PTDF1L3y5VhVKzOoSQrcVAMpGn/nHFUePDF6lnwbFi3OaSrZ6SfxeDWov
         cVQA==
X-Gm-Message-State: AAQBX9flSkvxBJB5cpnL9vgw2rdn+O/ad9u84KVDS7PII5MO9BhvvGMp
        KfkV413SolSvbssm45Ji3mVrVnSKnw5xWoPGoS6v2w==
X-Google-Smtp-Source: AKy350ZQcjae49tCy6oNT4305N+Z4S8+Y7ujTXsVfhIJKWegMcKISgvj8/M2PyjvwLANblxKgtuXyYV3MUZVo7I3qms=
X-Received: by 2002:a17:902:dace:b0:1a0:41ea:b9ba with SMTP id
 q14-20020a170902dace00b001a041eab9bamr768901plx.8.1679653932429; Fri, 24 Mar
 2023 03:32:12 -0700 (PDT)
MIME-Version: 1.0
From:   Stella Jacob <stella@infob2bdata.com>
Date:   Fri, 24 Mar 2023 05:32:00 -0500
Message-ID: <CADH7MrHv=1LpOVzS+BemAgGSJY3EtGZq2YnydQHjLXO9agr9=A@mail.gmail.com>
Subject: RE: Fintech Meetup Attendees Email List- 2023
To:     Stella Jacob <stella@infob2bdata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

I hope you=E2=80=99re having a great week!

Would you be interested in acquiring Fintech Meetup Attendees Email List 20=
23?

List Includes:- Org-Name, First Name, Last Name, Contact Job Title,
Verified Email Address, Website URL, Mailing Address, Phone Number,
Fax Number, Industry and many more=E2=80=A6

Number of Contacts :- 6,386 Verified Contacts.
Cost : $1,489

Kind Regards,
Stella Jacob
Marketing Coordinator
