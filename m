Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870DA1CD6CE
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 12:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgEKKqh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 06:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728209AbgEKKqh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 May 2020 06:46:37 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD250C061A0C
        for <dmaengine@vger.kernel.org>; Mon, 11 May 2020 03:46:35 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g9so650434edr.8
        for <dmaengine@vger.kernel.org>; Mon, 11 May 2020 03:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=urJaoEU+KjNM8t/1W6rOD5GSwCsLZCnOcRW+jTf5YXE=;
        b=Ms5aX7PKhyl1ejvyS3mnFs2nrNI7o9KLkrVFTPKNqwRnap699bfDKc9D6s/vSUipxY
         FcAiZPLw3t+NcJaMlBhdvTCt08tF4hqsZhyBhh1YG7SxLRFfA1Zu3YEKhkCMUMYPxI6H
         9zmn6kQqdvWEwZ0ZGT0oWX1/cOHDbzocBIVHwwX2eKzRjLVvU2Kff77bPXeRxVkHcwq3
         TGbBnN168spbj604i2YNRNCmZ3LREk8XX577TjlA6Ktvvs4/z5JzGIpmPRvykVGXAmxd
         C1moJkh5Bs777C9cgkrHv+RmbCaoHSDa24U5ntO2hDwx4OshBUHLh3W31g1z1ofboKB8
         BStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=urJaoEU+KjNM8t/1W6rOD5GSwCsLZCnOcRW+jTf5YXE=;
        b=lOmyHjGJiiFYyyt9KV15l9QdLPUEDYoPk+lQKu3b4LAD9JkTgQkE0WKOlxv56gR4ZJ
         s5tw8fZtGtWBgbWw+J8vcCqUmaWC+ZmUHjvXfK0aEUE37xGArXG0wy0djQVI4k0UckT3
         DvxkAi6gqeohG3nyLcx37NvNRVnKcsEsA7IJ/a6UpbempuL+Z687IvHyXqhYl4SfXO1N
         7YOzFx2fGoHdIXzh3gD+Q9zNz13JhNwsnLCFs+Bo8Y7mHId98hoFeb5JE6hjWQ/d9sbx
         8G+GFmT6spWWnidNUqAEaHzjB3AQIXK145FvEzsamFRyqOWiMbBLdUOtpIIdP/+axaax
         WcGQ==
X-Gm-Message-State: AGi0PuZCElcUrpe1VhSr3MCWUhJW2Lm65isy9kgXvgvqFuBVTMuijOQa
        RB9I1lyFo54LB10AsyjL+jeyrQKB5w+59f+4l/0=
X-Google-Smtp-Source: APiQypKHPD8WQl5PzmD5IhowpK2bhwpFyWu9KvvRIuxOVec1ue35BXCcqWpfO0EbdFjdmjdqBSG4tdgoyLg8B1+ZCyw=
X-Received: by 2002:a05:6402:1a46:: with SMTP id bf6mr12476835edb.44.1589193994538;
 Mon, 11 May 2020 03:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <1588761371-9078-1-git-send-email-amittomer25@gmail.com>
 <1588761371-9078-2-git-send-email-amittomer25@gmail.com> <20200510155159.GA27924@Mani-XPS-13-9360>
In-Reply-To: <20200510155159.GA27924@Mani-XPS-13-9360>
From:   Amit Tomer <amittomer25@gmail.com>
Date:   Mon, 11 May 2020 16:15:57 +0530
Message-ID: <CABHD4K_h7wc1gc3wvya1PRTRjMRkDPW==yrAWSk7cCF9ghkUjg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/8] dmaengine: Actions: get rid of bit fields from
 dma descriptor
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andre Przywara <andre.przywara@arm.com>, vkoul@kernel.org,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi

Thanks for the reply.

> I'm in favor of getting rid of bitfields due to its not so defined way of
> working (and forgive me for using it in first place) but I don't quite like
> the current approach.

Because , its less readable the way we are writing to those different fields ?
But this can be made more verbose by adding some comments around .

> Rather I'd like to have custom bitmasks (S900/S700/S500?) for writing to those
> fields.
>
I think S900 and S500 are same as pointed out by Cristian. and I didn't get by
creating custom bitmasks for it ?

Did you mean function like:

lli->hw[OWL_DMADESC_FLEN]= llc_hw_FLEN(len, FCNT_VALUE, FCNT_SHIFT);

Thanks
-Amit
