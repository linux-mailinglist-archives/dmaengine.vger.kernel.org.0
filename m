Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D234D571678
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jul 2022 12:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiGLKDG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jul 2022 06:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbiGLKCo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Jul 2022 06:02:44 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2AEAAB05
        for <dmaengine@vger.kernel.org>; Tue, 12 Jul 2022 03:02:30 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g126so7074004pfb.3
        for <dmaengine@vger.kernel.org>; Tue, 12 Jul 2022 03:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=kTnWqPCQ7JZ842fbaIQWezAeKboDsupaMXi3CH+q7qQ=;
        b=jEmpisi4afoc/nHOU5JQkrY9q8oem2RmDuiTiBt3GC2Cx8wfFpnUDtUan6G+ethOEl
         9DWvvVUyC0PdjRZm+pDetplM1lV5cs+WntQ5XcR4cLK2Ww8vuBE+Bzt0NILIOZwnflnx
         erJa6BiBnYy0Mj1nABPGSE/apdbRgI+kxW0a2OBBx4oMcfPt+8vx7xF7WBKUBFBCwGdf
         WM4gPY1wEFTg+mki1DPbH/72uoFGbTkTspg4xhLeGNwmE96j1IrDuzzWvsCVHg7TAE32
         g4373JweeR1CzyTiSKtiSPmFyklF15yk0A3htHD1IQQNaVi4y7NoC2geB78P9CnsL61X
         OPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=kTnWqPCQ7JZ842fbaIQWezAeKboDsupaMXi3CH+q7qQ=;
        b=hM1UMDjUrmzItdyBWAU8gttvnmJpoT9LIyJVmC2s+VjFGfkRf5lGgd/ZierjXqavO+
         VO7kIyKS7nxBMX/tj79luSIohaibaXf4NGWS3zv6sXxitjxhfQzlcKOqbGfRXU0H0AxX
         Dl12jyYbZMiAw8j+Tdn4LHvoSlh9WbMjZ/NJXqSLIgkUeoZxzJRiDoMx7FCq7WeFCeAM
         fcvQNE37IJnIihFJ7YD5krYXArNuF4VlqddvcDakRyV7zWeUCEw/OWAweg4n/zsTTNtK
         n6Nich9aOX8onbBax4BqUSVAhaXhIbrCyc+gHTvNsX5ute08SqevL19MAdh1TYlpSMI4
         86Pg==
X-Gm-Message-State: AJIora9SGzZGnCGbgdsxkux8/HkKAO44m246mUD+erV67zFDBfN7oJJV
        rR1VK3sdVsGqVzkChyPkeSS4q4TalNLFNsMUIGo=
X-Google-Smtp-Source: AGRyM1tnbr9acvlTxECkT/xzXjqGENF0i/7mX5JM0b59OTpLQG2EeT070zOO48wSKtt0SUYYZsfirUJMLljq9cARruo=
X-Received: by 2002:a05:6a00:4407:b0:52a:e996:780c with SMTP id
 br7-20020a056a00440700b0052ae996780cmr2036850pfb.40.1657620150315; Tue, 12
 Jul 2022 03:02:30 -0700 (PDT)
MIME-Version: 1.0
Sender: hr.falocoltd@gmail.com
Received: by 2002:a17:90b:2247:0:0:0:0 with HTTP; Tue, 12 Jul 2022 03:02:29
 -0700 (PDT)
From:   Al muharraq group <al.muharraqgrp@gmail.com>
Date:   Tue, 12 Jul 2022 11:02:29 +0100
X-Google-Sender-Auth: 9no9VMOlNRuRofgOK3tR-6V8HSc
Message-ID: <CA+c3rs3Duub2uFUNtNBTX7qDnuzCau=O710bF8jvHQeHHYR6tg@mail.gmail.com>
Subject: Al-Muharraq Project funding
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

-- 
Greetings from Al-Muharraq Group Ltd.

I have contacted you to consult you for a funding resolution for your business.

My Name is Saif Yusuf. Do you have projects that require funding? We
facilitate the funding needs of private project owners around the
world covering infrastructure, housing, real estate development, IT
parks, industrial parks, film studios, food parks, agricultural
projects, health & wellness, hospitality, education, electronics &
telecommunication, power & electricity and oil and gas sectors.

If you have any queries regarding funding please revert back to me and
find the solution to your financial needs.


Sincerely,


Saif Yusuf
Business Consultant

Al-MUHARRAQ Group.
#sblcproviders #bankguarantee #mortgageloans #unsecuredloan
#projectfinance #startuploan #tradefund
