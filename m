Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 579D838521
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2019 09:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfFGHhZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jun 2019 03:37:25 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44793 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGHhZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jun 2019 03:37:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so826625lfm.11;
        Fri, 07 Jun 2019 00:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQVVk6mF9EAcAiThkhp4p+6/hnUydSTwfuq+LxUaFKM=;
        b=V4jxgBIRm0EIOeHgrALtXjf0+uj2Ajle/e1wiIe2dKmZOpAHFyWV8IS6Ntc1RexRPk
         XGwnoM9xyHJvQgy3BnU86lAGpo0Iq3F8RSDcvDvVFGpCIJ8GIFtgO1g6nJKVX0zm92Qz
         XN6ZuEvT7WS7siq9QMlv0kRZPwH3hWYNtAeKVkxtX8xQxHBfQdfBEVajfTfMP3CasE/P
         iYINrc+0qdwaxdRFDtOyPv3nFSSzW5G0v15KlCcCT3z8uCHyDW83ELPCPPjpNR0C7Pq+
         VbDrroiYLJ4DJV2tt9LMhW2L+WcRIBbknQNLDJsV1UtdwWs+hZagmnWtDiOCMpB7gnyx
         pmqQ==
X-Gm-Message-State: APjAAAXicAKuGUcRZ2gN6NfP45y2JSfRqlLydD5/sHdG2EDf/A1X9U4H
        UUaSf+3Q9sSb1QC3zZeN1rM8uYUHABrpg8xssqo=
X-Google-Smtp-Source: APXvYqzK7J8UfuHaLs+J2oXg8+7dGuQ5QjgppXyPzbPKScKOPeg9uRWJ0ZtTeTShdlu3NIo3m8J6i+gKK4Sy5v7X5LM=
X-Received: by 2002:ac2:597c:: with SMTP id h28mr2043903lfp.90.1559893042993;
 Fri, 07 Jun 2019 00:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190524002847.30961-1-dinguyen@kernel.org> <20190524002847.30961-2-dinguyen@kernel.org>
 <20190604121424.GW15118@vkoul-mobl> <1dd97825-f6a2-7a1b-33ef-e28e00cc8506@kernel.org>
 <CAMuHMdV+_DzS+LD720BeAn05RzYGO9rS51-ucicP=8D0wz9Psg@mail.gmail.com>
 <00841780-ad68-ba8d-bdf0-d3f78fa42c98@kernel.org> <55cc6016-f297-539d-df08-777903b79005@kernel.org>
In-Reply-To: <55cc6016-f297-539d-df08-777903b79005@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 7 Jun 2019 09:37:10 +0200
Message-ID: <CAMuHMdWktznAYLTp5t6PJy2+qcbs-5SHy4zCLUXYjRS3DqUZnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dmagengine: pl330: add code to get reset property
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Dinh,

On Wed, Jun 5, 2019 at 5:31 PM Dinh Nguyen <dinguyen@kernel.org> wrote:
> On 6/5/19 9:41 AM, Dinh Nguyen wrote:
> > On 6/4/19 11:31 AM, Geert Uytterhoeven wrote:
> >> On Tue, Jun 4, 2019 at 4:21 PM Dinh Nguyen <dinguyen@kernel.org> wrote:
> >>> On 6/4/19 7:14 AM, Vinod Koul wrote:
> >>>> On 23-05-19, 19:28, Dinh Nguyen wrote:
> >>>>> The DMA controller on some SoCs can be held in reset, and thus requires
> >>>>> the reset signal(s) to deasserted. Most SoCs will have just one reset
> >>>>> signal, but there are others, i.e. Arria10/Stratix10 will have an
> >>>>> additional reset signal, referred to as the OCP.
> >>>>>
> >>>>> Add code to get the reset property from the device tree for deassert and
> >>>>> assert.
> >>>>>
> >>>>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>

> >>>>> --- a/drivers/dma/pl330.c
> >>>>> +++ b/drivers/dma/pl330.c

> >>>>> @@ -3028,6 +3032,30 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
> >>>>>
> >>>>>      amba_set_drvdata(adev, pl330);
> >>>>>
> >>>>> +    pl330->rstc = devm_reset_control_get_optional(&adev->dev, "dma");
> >>>>> +    if (IS_ERR(pl330->rstc)) {
> >>>>> +            dev_err(&adev->dev, "No reset controller specified.\n");

"No reset controller specified.\n"

> >>>>
> >>>> Wasnt this optional??
> >>>
> >>> Yes, this is optional. The call devm_reset_control_get_optional() will
> >>> just return NULL if the reset property is not there, but an error
> >>> pointer if something really went wrong. Thus, I'm using IS_ERR() for the
> >>> error checking.
> >>
> >> So the error message is incorrect, as this is a real error condition?
> >
> > Yes, you're right! Will correct in V2.
>
> Looking at this again, I think the error message is correct. The
> optional call will return NULL if the resets property is not specified,
> and will return an error pointer if the reset propert is specified, but
> the pointer to the reset controller is not found.
>
> So I think the error message is correct.

Please reread the error message, and what you wrote above.

Error message: "No reset controller specified".
Rationale: NULL (i.e. no error) if "the resets property is not specified".

If an error pointer is returned, this may be due to probe deferral (to be
propagated, but further ignored), or due to a real failure.

So IMHO the code should read:

        if (IS_ERR(pl330->rstc)) {
                if (PTR_ERR(pl330->rstc) != -EPROBE_DEFER)
                        dev_err(&adev->dev, "Failed to get reset.\n");
                return PTR_ERR(pl330->rstc);
        } else { ... }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
