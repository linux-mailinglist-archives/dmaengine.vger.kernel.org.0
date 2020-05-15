Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E14E1D4C2E
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2020 13:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgEOLMM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 May 2020 07:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgEOLML (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 May 2020 07:12:11 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B04EC061A0C
        for <dmaengine@vger.kernel.org>; Fri, 15 May 2020 04:12:11 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l21so1887700eji.4
        for <dmaengine@vger.kernel.org>; Fri, 15 May 2020 04:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mDPmX+zBOB1FOVcPGDXxtVKn0gcZ1qfhCRVWeTxq8uE=;
        b=r/XGnEaxt/IlcucOMaN3sI+Tptdk5KSSK1jNiq+OfqytAfLNuieRI02BKpUT4ym3Yc
         p20kSvAg85TX+qcGEM68nG5NKC272BkkbstQ1O8TIIpjGvCGY/B6VLRi9pp4RXb9Iftl
         zlpUX0mf5VBou3CNPJTs12nQMkm4i06fCn6oDehO0iSrYbQhxxBn50S/zxtJdVYBKvAf
         fXFFmnd4uhJEOuE3rtfbWyOOL45K77nvUjzc9X7T1CpXnUDIw7aob1QLXz6qJyXS6feQ
         luSgeSW6SwA6/jM8VgYlXqJXamPw1XMJWWsfEMvhZNCehu/+bpz45c+HVdp6lpZa+kMz
         oyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDPmX+zBOB1FOVcPGDXxtVKn0gcZ1qfhCRVWeTxq8uE=;
        b=MMvhQik0E6C5qEuEPJS49kGRmkxNx1qXZ7vnP1hasV25xYMwzt3a4mqSeXTTdGxomh
         BxbXc0aj32DOS7X0oiPibpGtWM2/t3cLfCxzwQQDDSvFYJZG7jnQVXjwT1+KjEjra71X
         Y51edF++UnV0yr/lnm7OXlB8QBhiWFVjqymMrv+0Tn85U6Mo4RA+pduVs+d6+XNPuXgm
         02/GyULczTi7/rAuZkbAtIMlVnrj/mL9c8MknMIEI/r7RmyF9V9bG5Z24167Akm1R7i5
         E8/U+zBXVtDvG5huRbo9L+hXR5tOqWvKWwS7EomINFjT5cmJfd2V1DKIEKPc8hFXCr37
         ltjw==
X-Gm-Message-State: AOAM530vh8JlqDZwyVInM1Jfs26Qi42FTG8mBAzLXKrsgrlyOiOxCZTL
        ddIDt4MR5iNez5nTv/OKUZkDYNyelHkqeyF2Kk0=
X-Google-Smtp-Source: ABdhPJyhR5Qi/o52NNgorqHZojlWgNxoKOe4vSX9Z7H8DNlGfH8Y07x1O5/FkONXwvRt6pldVQ0otaZTj0aHFftlGdU=
X-Received: by 2002:a17:906:d8c1:: with SMTP id re1mr2275220ejb.184.1589541129907;
 Fri, 15 May 2020 04:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <1589472657-3930-1-git-send-email-amittomer25@gmail.com>
 <1589472657-3930-2-git-send-email-amittomer25@gmail.com> <20200514182750.GJ14092@vkoul-mobl>
 <CABHD4K8F_sk3Xsevu4pMtR1jEanh5-dSATLYySPKW-nDY9fAvA@mail.gmail.com>
 <20200515065827.GL333670@vkoul-mobl> <CABHD4K92yySOJs9heBienGBieu6N+ALj7NKcAPvThQGXMWfOdA@mail.gmail.com>
In-Reply-To: <CABHD4K92yySOJs9heBienGBieu6N+ALj7NKcAPvThQGXMWfOdA@mail.gmail.com>
From:   Amit Tomer <amittomer25@gmail.com>
Date:   Fri, 15 May 2020 16:41:33 +0530
Message-ID: <CABHD4K-njmpbJQ3XR+qfgTK0QCOF819o6JCaSJcEn05-jqTNCw@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] dmaengine: Actions: get rid of bit fields from dma descriptor
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

> I do have a cover letter for this series , But CCed only to Actions
> Semi SoC maintainers
> and mailing list.

and following is the link to cover letter for v1:

http://lists.infradead.org/pipermail/linux-arm-kernel/2020-May/732075.html

Thanks
-Amit
