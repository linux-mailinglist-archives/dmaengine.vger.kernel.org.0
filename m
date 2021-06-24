Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA86E3B3134
	for <lists+dmaengine@lfdr.de>; Thu, 24 Jun 2021 16:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhFXO0f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Jun 2021 10:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhFXO0e (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Jun 2021 10:26:34 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6AFC061574
        for <dmaengine@vger.kernel.org>; Thu, 24 Jun 2021 07:24:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id f30so10669156lfj.1
        for <dmaengine@vger.kernel.org>; Thu, 24 Jun 2021 07:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=Vs/mdGFmVHCp81S6vlg3pAnEqbVcX/o3GUnWuUD7BioKulPIFtg4Nh0D8vQveVMWfB
         1ixqJ98yI38K1H4VQezw1iEronGJzP6H14pMMk8R03kRokoULjUfgWoJeKGeNIjHV49u
         eAbIFL9O23u/Gd31a9ckrQNEnAk3t6I4NjM/eijlQU/8OvYNlkS3q0k4Lh1MdQeWFhjc
         TvBST1h1mcuOD9ue2fvSazB40aWzf+xj844tX82oRS8a/CDIVBiMjwHoWtGqe/tAnjcu
         Xh2T1LxQ/9FqSh6ZM+uecMD0709u6dRJ8LEzhaxvID5fBJfoIiEZk1UMQm/a5kSoDgz8
         5bBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=SSXmkeKLxziLx8vhfaN/BB51xzJ5rxlvG5P5sROw6GiPjMYhvbNedKvu1/ByzAxzFo
         JK8YKXK2mJH9uYoUf1UpVniZBgRIt9harJNR+cBp0bYLWI8W5fIPlcP/H7lCT8rw7XH/
         oGE5A3KKY9ST+hs2LuWsfySOEYKoFTlFJlD3ELoBcSfMu3jatLPbXRxdg4Cw+RMU+WuA
         vgPkjvyKaBHp1QjgXN9d4eGhqoH1HUCF0KLAFb+SdmNFXMoT4RQDBgh4dKr10JadAw8M
         8F1GUuWLq0VECB5YGUltMFn+OeDG1sdZZOpEbCwHA33yeWB0B1JlRijWatpnliRm/j1J
         lOWA==
X-Gm-Message-State: AOAM5312nnYnkX327K1IQDVx0kmg03Bc1TsXIWMTKdyYSipgq5NnSB0k
        NHp/9AL3EiWgSxp+l3i517YRK5qlldgJbRSJ4QM=
X-Google-Smtp-Source: ABdhPJxflVQ7kmqsY97IDZUOxJIX86ETQAYQYgqSJo5k4V0+1qz+kGCAguvBOunqZ005WaLvy+XQz9uZMuKTsvs7KXQ=
X-Received: by 2002:a05:6512:e8a:: with SMTP id bi10mr3988351lfb.601.1624544652237;
 Thu, 24 Jun 2021 07:24:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:651c:1a1:0:0:0:0 with HTTP; Thu, 24 Jun 2021 07:24:11
 -0700 (PDT)
Reply-To: tutywoolgar021@gmail.com
In-Reply-To: <CACGGhyQDhNjM7pPW0wTzyn7LBiGmaBAqeP5L66y=E2TL4U9+PQ@mail.gmail.com>
References: <CACGGhyQDhNjM7pPW0wTzyn7LBiGmaBAqeP5L66y=E2TL4U9+PQ@mail.gmail.com>
From:   tuty woolgar <assihbernard6@gmail.com>
Date:   Thu, 24 Jun 2021 14:24:11 +0000
Message-ID: <CACGGhyRPL1c3+NWJGn90fNhbuf2TgbFsw5V3VJ=F9JSnH8NJsQ@mail.gmail.com>
Subject: greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

My greetings to you my friend i hope you are fine and good please respond
back to me thanks,
