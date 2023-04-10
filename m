Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F086DC567
	for <lists+dmaengine@lfdr.de>; Mon, 10 Apr 2023 11:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjDJJ4I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Apr 2023 05:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjDJJ4C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Apr 2023 05:56:02 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD542727
        for <dmaengine@vger.kernel.org>; Mon, 10 Apr 2023 02:55:48 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id dv4so1463356qkb.2
        for <dmaengine@vger.kernel.org>; Mon, 10 Apr 2023 02:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681120547;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2sHlxl35sZ/0kX13ZMTgKP0K7d8IxjTMQR+NacLmn0=;
        b=mUsasbg0WwaKKsfG18RCZLQ2nsdwh0x0LpLdGZw0TAgAwoVAt2B+DFGnE6vzrXutlB
         pH6YlOJUlhVZFn3LdT9raqzccoBPZjhLAoPBrn52+wTivReBztLKOqAZC7ow+n2Yiahj
         bjRweVzv5RdYXjRgwfJ64yXyaq4yJ+dTm9dkMLZFmJyg92djr+FlQ73W7yj/cnNjMK+g
         R6FxaqhzHaV66oUi7hZEC2cdHzk4PPbv34icDE3pwGAcQWjbOhe72zqilJaBj8HGJnxm
         D9EzXMEtwRMqEbZDDSkTGQfwTnv5v+q4XAgvv9uv+ANjejeFtd6C9YtGO1SjN4tUtZ5d
         2K5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681120547;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2sHlxl35sZ/0kX13ZMTgKP0K7d8IxjTMQR+NacLmn0=;
        b=KPa4/rKul2iIi+skqhgfUn5ZMTHRaf3id0+Nz8U2cyKtS397Aw32ceABcJKPqmzYPW
         Nhrcv9JMtRiXPOaDuIlcdG+OPHXx1lChTzcJmObGnCoYUcWJjCOrqq98ZGdwQon/fBxg
         R9K/HK5ClcdTS2wO/hcI//8WdnYdWL2N0tKmzpfVPJGEoG91mSQnG2/qvrzowSBgcLW0
         ig0xsNwiY8noKJgNMpCdYncjvol5oNY+o00QnA6j5FKUIRp0u9Ed3jcfQ7n/5kIwLtK3
         4hTdKQA/xJGMyd2racWdv79qw5DPzQ/oTnDPtQ2/JxE5288cdrHB1EliL4Bi+wKiXq+9
         GRUg==
X-Gm-Message-State: AAQBX9fv6UZliPqnr2WRMMZop1MTJIOeclCl0PdMthdtgqhhevD8bDyV
        /G5n4VlWz/5RqmjHtDaAuIAE4n70F5bx9Sj8+B4=
X-Google-Smtp-Source: AKy350aJ+FvSYp0UYQTJkGqIbELeha1DFPJ7l/GQIPzTj5PlWg5sN5I4wKt6zhfcWbP8dGAvCaXKcr/VaIym9GUVU30=
X-Received: by 2002:a05:620a:40c2:b0:746:145:5ae with SMTP id
 g2-20020a05620a40c200b00746014505aemr3258492qko.2.1681120547284; Mon, 10 Apr
 2023 02:55:47 -0700 (PDT)
MIME-Version: 1.0
Sender: mrssaliya.fatima.goffery.salam20@gmail.com
Received: by 2002:ac8:5b01:0:b0:3bf:da69:60f6 with HTTP; Mon, 10 Apr 2023
 02:55:46 -0700 (PDT)
From:   "Mrs. Bill Chantal Govo Desmond" <mrsbillchantal.govo@gmail.com>
Date:   Mon, 10 Apr 2023 02:55:46 -0700
X-Google-Sender-Auth: y5uePGCn07Lj4UiKMy2PwZW-BYc
Message-ID: <CAGqHh--ph7YA8=ctR6V9cOSOrxCCY8NCMb7eSeQvfjuKxG+J1A@mail.gmail.com>
Subject: Hello Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Good Day, you have been compensated with the sum of 3.6 million U.S

dollars in this united nation.

The payment will be issue into atm visa card and send to you from the

Santander bank of Spain.

We need your address and your whatsaap number. My email.ID

(mrsbillchantal.govo@gmail.com).

Thanks
From
Mrs. Bill Chantal Govo Desmond
