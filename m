Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A82E63C906
	for <lists+dmaengine@lfdr.de>; Tue, 29 Nov 2022 21:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbiK2UNo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Nov 2022 15:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbiK2UNn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 29 Nov 2022 15:13:43 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B032BB3A
        for <dmaengine@vger.kernel.org>; Tue, 29 Nov 2022 12:13:42 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id z4so18572717ljq.6
        for <dmaengine@vger.kernel.org>; Tue, 29 Nov 2022 12:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=fM2wi5GCSslz9CIyZBqJ6Udlyv0ggnfAc0ToenEo3YH4B7+Tl74tXXdEb5EKWkn2Wu
         DIs7Qd8CDoudOH9YwohFYngsDQ9eCPghIM38/LWagmk9cGphExczFuqtUy/bGB9d7Pqw
         YVh9ccSRgw291h59omJ1P20R9/ybbwpZoN3qp0TugbORvlQPA/QDp8KlGHc7ZTTuKkcu
         6WmDWiSHuUHNnpsDYR8ju/sHsfkUFY9wld5yIlzuFpBJnUYYNjp7/Qa+lrHFccgnfU5e
         9nY+xCPnFS5/Yss+sn0ObgtuuAqpMKmiqDcPNqJ0d7KbTPqKIvWDl8Bil/6pXZIZrxTa
         ADyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=wbwnXZff+0EBFDKZ++qU2wNAO3Eyn++E4Wq6OPhydoZ+5BRfZOkZglxH+IBVFZk+NE
         M/hLequUzb8M1pwUz5PmTN3Y7hmy35Q8NCrSjRyz1DuWhn/k9Nc3MvM/4m39ZVdzrNZC
         3++c4Z2xKCkV49Wrh1Idi92dj4pdhFEQvDoQhV705aoNAFuSKdHqh14/ayldosXTkqcX
         4b/X6/wYS3IJ5z/4PCXjBokeoJYu3vIcHrGISl99IROJzoDKXO0MrnqxBtwk7g4ZYvN3
         dvGrhWLUsS1lp33XhTM4/Od9Vhu5jdgd4qWyD+sWp1LrTj/Wb/VyGdqX5qAZX0ANptZq
         LefA==
X-Gm-Message-State: ANoB5pms8At+w1L+NzsS3M1bjoebzjhUc9nDX/fU5YTCrabGIFblYwKK
        hlit9Piuse2+GLYmQvNHGujnGijw9204qKVo0VI=
X-Google-Smtp-Source: AA0mqf4+F9TyDQP1Ce2PfnR/pYBFWTAEF62pD7GZYkg7CduLXEkkJypQXMVWDo+1vw39/WFBYPCVnCuXdFNJSBE+AXs=
X-Received: by 2002:a2e:a543:0:b0:277:8f64:f9fa with SMTP id
 e3-20020a2ea543000000b002778f64f9famr14243228ljn.282.1669752820449; Tue, 29
 Nov 2022 12:13:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6520:2542:b0:22c:9bbc:bff with HTTP; Tue, 29 Nov 2022
 12:13:39 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <joykekeli2@gmail.com>
Date:   Tue, 29 Nov 2022 20:13:39 +0000
Message-ID: <CAOikvbtX13y9cXe+vd11-fxb5BMQHxP-R2ju-NE4AaEGAMxSuA@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
