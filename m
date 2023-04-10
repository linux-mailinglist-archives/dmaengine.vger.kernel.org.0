Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750CC6DC3E6
	for <lists+dmaengine@lfdr.de>; Mon, 10 Apr 2023 09:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjDJHgq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Apr 2023 03:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDJHgq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Apr 2023 03:36:46 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434C62737
        for <dmaengine@vger.kernel.org>; Mon, 10 Apr 2023 00:36:41 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id z26so3929422ljq.3
        for <dmaengine@vger.kernel.org>; Mon, 10 Apr 2023 00:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681112199;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5Ai8ftFGf/7qrHxBDCebvM00XXHdhtlOXD7WyAX9HQ=;
        b=CJHKlIEj0FCAGqIqqslL954qDHXv/FG+NvffE2tQd7ODyc9KbYr/+D/39CppkidvN1
         48jDX8A+sOij4Izk6NMmYJgPfjFTIrFQVbOP0ojbC6/g9/AkIu7/8zQq5Md7biKK2IIG
         Tw3mfUVSZhaIwUO3ZAxMCzupBrhOeWljmkXvJ7Lc6n57WHMb9OmzNrvtxjcWaKx3Odbf
         fQMIVTbME/ExMtq+QqhidbmhtXpZYF8rVgzlLgqj5COB8YxvvqSSb96fXyWMI0ZLUTbK
         x8JAFWDWkQAIbvQNg7dcDRb9zGUpMo6pVq1jN+ofrhk0B0+HUeU4g/ZqNVIdr+/3VgXG
         DmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681112199;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5Ai8ftFGf/7qrHxBDCebvM00XXHdhtlOXD7WyAX9HQ=;
        b=u7n3sWsv92W2aTPmvF9i1nTuOw0U8hRttrnsg75azSatE01Bw34TmqcWv5DwurCSQx
         aE4nz3fqPkYiGZSrm0/s4w5gPmgqQkpse+S3XIQUzvnGRt2o5vQ6dvJ8MlOiraY5GmuI
         kpCN30CEbEDD1kcuE2bYVFR62dYz3DJVAcxVx31BYuyAmpSpJHu3KjA4J+gZtsSeiRkG
         8RbUYOrJgdVdVXtHrRcxBB1dkYzP8Xfmq4qZrt9BH7eBvrPfG/DPbKXjwHO8q/U7BoX8
         4pihQTvvzia+ow2S6zh9w1It+0XeDHl0Cg/NFaj6fpxnT0Ow085+BqBHi5nDhINTB/io
         oOjw==
X-Gm-Message-State: AAQBX9dPVM0f3u1zv+wmDJqsWIY9lC157Zja70KYksBKhhOXeJWKZNiS
        H61Q5oisB6cLkyPxO4QvIV7PfS+D+/IPxgiJ0WA=
X-Google-Smtp-Source: AKy350ZysFGAufi6n6WETHttPHLbJ0KEyim9FS4UrfrnSx0g/vRjqEALFnDVxhek3cpyiTvLnLbl84kJFdS2v9gCAQ0=
X-Received: by 2002:a2e:9c55:0:b0:298:b320:ee2d with SMTP id
 t21-20020a2e9c55000000b00298b320ee2dmr2563415ljj.0.1681112199237; Mon, 10 Apr
 2023 00:36:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa6:c22c:0:b0:25c:30a9:777e with HTTP; Mon, 10 Apr 2023
 00:36:38 -0700 (PDT)
Reply-To: nepk08544@gmail.com
From:   Leihservice <auwalualiyumalam46@gmail.com>
Date:   Mon, 10 Apr 2023 00:36:38 -0700
Message-ID: <CAHQtquREXzvPyt9A9NQ3jh8L9mRMKFF9n-h32DGyRCRwV6wGeg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

-- 
Holen Sie sich ein einfaches Darlehen mit einem Zinssatz von 2 %
