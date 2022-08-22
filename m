Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39C659CC1C
	for <lists+dmaengine@lfdr.de>; Tue, 23 Aug 2022 01:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbiHVXXq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Aug 2022 19:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238664AbiHVXXg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Aug 2022 19:23:36 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DFA13D10
        for <dmaengine@vger.kernel.org>; Mon, 22 Aug 2022 16:23:34 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id q16so6560386ile.1
        for <dmaengine@vger.kernel.org>; Mon, 22 Aug 2022 16:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=C9OtDfatTdiphdlWN7zsS/2P0Fjf45auQYVLd+4H5vo=;
        b=F54/qMvHLBqGuFsn6Rabi5oXvmYokIWgEvDoL3IsgxRdsmLORlBePAbSTG5bX1i8ke
         yVYIdSzqVFK4vSgKYYjfLNWbl04tajM/fILa2khEZNBULqO43NIbUWKMMaP9QkOx5X4c
         giZ4vZlRxF1IQeacN2arUDL639VAKY4A2UuEGmom+DXM2drNeYYegMOFpZByHgknqYc5
         oYosYYa8HChcQujqb7RrHNU2E2oJkB7ph0KegfMFthdhP7piU9QlwzV/DvaTwxidAdlm
         tnuGd6MbhAbmOJS3HMjXLCd9OgJM+NXJxJIsxbGpplLUS2uEdQbPTDQRACB4LdEauwTS
         MLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=C9OtDfatTdiphdlWN7zsS/2P0Fjf45auQYVLd+4H5vo=;
        b=dwcw+sFpTqBEK34u5oTdolGcDm50B8HQuTSvP625QMbCZTIx6soxev3EY/AambJesj
         Yijj+h7NKlMyz44woK5NKssKwFgSiAaqvCC7A+3gzOQXszlHwXpPSCHlIZaadOYLD/TV
         VCjlI1AGDY8SfkSZJmxoH4UYg+YUUqI1aTw1WFf6lQib5xS38cKJcqIWNuDORefShplb
         a8zrysU/Q5Zn7jHEU2jNbNaJYbUHsTBKT/KNRlgdOEVjVqm5ZCE1W9aLO9wAY1EgtvLx
         p8EmXuEkjp+yWbtKsqNproqUdM02UQcG28gzvpCDt2NX8U3SpEO0hB58zsc3PAuDe5A6
         QGag==
X-Gm-Message-State: ACgBeo1uQJAo5j5qwtsJNXXkqO3aIXPy64dh9VvMJuRG+mUX4C+braq5
        gnz5Cw0ENb5yABWvRqkn42CVwAKej1sreYm49IQ=
X-Google-Smtp-Source: AA6agR6ZDYdhu3uuQds7i4lJP2qanepZBvKiUt/debHdTxtPKGLDfaIA79y+da3HobqQdSpeNCN7IfvxXKDXT6ZvQNQ=
X-Received: by 2002:a05:6e02:1a24:b0:2e5:e2f5:1664 with SMTP id
 g4-20020a056e021a2400b002e5e2f51664mr11234647ile.231.1661210613458; Mon, 22
 Aug 2022 16:23:33 -0700 (PDT)
MIME-Version: 1.0
Sender: tionne651@gmail.com
Received: by 2002:a02:3809:0:b0:349:d00a:ff85 with HTTP; Mon, 22 Aug 2022
 16:23:33 -0700 (PDT)
From:   Pavillion Tchi <tchipavillion7@gmail.com>
Date:   Mon, 22 Aug 2022 23:23:33 +0000
X-Google-Sender-Auth: uk2eUViau5kvcAwxbp7gNj-_NSk
Message-ID: <CAFAgsVkcmKxLY3V6bJvfKjhBXc2Fk7Z9HL49_OF4xF2_Wqv65w@mail.gmail.com>
Subject: Hallo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

-- 
Hallo
Haben Sie meine vorherige E-Mail erhalten?
