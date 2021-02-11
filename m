Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C586E318BBB
	for <lists+dmaengine@lfdr.de>; Thu, 11 Feb 2021 14:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhBKNOB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Feb 2021 08:14:01 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:52424 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhBKNJn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 Feb 2021 08:09:43 -0500
Received: by mail-wm1-f47.google.com with SMTP id l17so3949665wmq.2;
        Thu, 11 Feb 2021 05:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/hyiDUn1nuAZwyfrhYMBKEkGylPh1bfSdPVBJUnfYe8=;
        b=oY+d3npcTl/b4qsSU9ElF4xuE5GZZsl35RKPnexx0zuDMtZ0ytKbVKocSPxLcNVaNr
         GnlJPkpHKBlMU/YmvRMw3mTrqHqW41FFsAeHUTgEw8HO+KTaOTaKnATlVAmA2p4HnegR
         GW9VVg/pTlPvM5qUwt8ckU31Bgopl8NxOAcGKeYFT6o6TciO7eQ/LT2AmEKGJp9/vssk
         UtcrySLqtG61ejsWxt9qw4AdaWOMCmo50Yqqz5sJi91fFtS2sZuaSSnsdhRZ7UwS4HDm
         jM+kkq3GNEJMUYSbL8ucahCuCz6ni9kVrMpwheABHLL2U/QLcff29zQ4bIHQQ17mLonS
         0DKA==
X-Gm-Message-State: AOAM531qUCwplaWSyt796Dt/YKP20v86ezcqXpB69SdwvsttAF+XJD/G
        +nX2nHALepWGcbk2wfAM4ns=
X-Google-Smtp-Source: ABdhPJynn/6V/k+F2FH90atf/MNGy9GzPd4LlQmtHbxaa+Z8LW8SHgfk4W3dehcyY/c6KTN1HkUbwQ==
X-Received: by 2002:a1c:750e:: with SMTP id o14mr5196550wmc.60.1613048939295;
        Thu, 11 Feb 2021 05:08:59 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n3sm4734030wrv.22.2021.02.11.05.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 05:08:58 -0800 (PST)
Date:   Thu, 11 Feb 2021 14:08:57 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 09/15] dmaengine: dw-edma: Improve the linked list and
 data blocks definition
Message-ID: <YCUsab1NaHxNG7sU@rocinante>
References: <cover.1613034728.git.gustavo.pimentel@synopsys.com>
 <52812d20d0624b36b92785517b2b61ae9b6cc1ed.1613034728.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52812d20d0624b36b92785517b2b61ae9b6cc1ed.1613034728.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Gustavo,

> In the previous implementation the driver assumes that only existed 2
> memory spaces that would be equal distributed amount the write/read
> channels.

What do you think about:

  In the previous implementation the driver assumed that there existed
  only two memory spaces that would equally distribute the amount of
  read/write channels.

> This might not be the case on some other implementations, therefore this
> patches changes this requirement so that each write/read channel has
[...]

Probably "patch" here.

Krzysztof
