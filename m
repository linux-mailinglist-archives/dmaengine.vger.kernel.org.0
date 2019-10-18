Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C01DC798
	for <lists+dmaengine@lfdr.de>; Fri, 18 Oct 2019 16:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410018AbfJROkg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Oct 2019 10:40:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34976 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405743AbfJROkf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Oct 2019 10:40:35 -0400
Received: by mail-lj1-f194.google.com with SMTP id m7so6508259lji.2;
        Fri, 18 Oct 2019 07:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhekE/lFDvGK9smHtHKW9B75PhpActfcuEQsgR03PLI=;
        b=SmfIDBz4FajL2rz5i28YQsDSeqEr3k0+TausX5oxkH/rt2ejAIZp/yyFOdCUIBgkIs
         FBDTtHnuiIzuC5h9sKB1FBZu73hEocNFvnDG2YpsVmllQgleNTCoa2SpZDFJFNLXEquM
         j7DAxxdVTuTnkS9JcH6TlXZmuCGtjFLWjIdyEdi0eGIRG+Nj5M4X5qf8ZQtWkYQjbyeR
         5xfaqKxsjKtV1nz/6DTEMTJh9JVEctyKQgnGkwqPnP+X9z3YRjscjzn+k2XySYMnjUFa
         bYDpejvg/4fLdekzwcQ85680PkAHwYUNV46xn6M60vGMLktAjqpJ3SFl+kmwA3Gc2rax
         BwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhekE/lFDvGK9smHtHKW9B75PhpActfcuEQsgR03PLI=;
        b=O169r3A/TUy4fwBcFFdbvratG5vrW/xZoucDC771oMgXdQx7yGr/47ve8By/ZOmW0v
         qbBQ7nlguwkFoTOoeAKec2TmJrP2k3yG4MvHjw1EOlnpdT8rYazvdtB8BqKfZqKO3Up1
         yFjug5S8rKUwv062sRu0Wa5CG10S8XiGcjqBOOHDnq6fYVt1a7HHISipMfmgFHkIBaIy
         sSo7mjT5afMqUpe2+O5uDdg+yXZtboOkfIkFOiP3+KuHMI5ACdyNtJmBiaBndDANzQ8l
         RxMDk2ATk7IJung5l+QLnpUYlqtNAXUJjYCQOUjc4EExdjL3A2EzV3+nYsrmP97D7S/S
         2hgw==
X-Gm-Message-State: APjAAAWQf0ULhuaJsRWE/Zjt6F6ahBfM4JRxC+J573uzyBOqtsK5WH0g
        CjEV2qyRLDU9OuEWYc1NhN28b0neZeC2LSdzULw=
X-Google-Smtp-Source: APXvYqzmAtBdI3iKS6kwkBU+iZZ+miA74+YjmhfjaH02+jPs1nkS5FVcZYYRPfV5gCIW75SPQmu2vlbVP6gBykwHZfs=
X-Received: by 2002:a2e:b4d5:: with SMTP id r21mr6309088ljm.149.1571409633342;
 Fri, 18 Oct 2019 07:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191017070923.6705-1-peng.ma@nxp.com> <CAOMZO5AK+wv0vAfqv7PC-gYF32MSD9nMqFCuRmLxMN6dYZdvGA@mail.gmail.com>
 <DB7PR04MB4425E937B423C39F0F45FCEDED6C0@DB7PR04MB4425.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB4425E937B423C39F0F45FCEDED6C0@DB7PR04MB4425.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 18 Oct 2019 11:40:24 -0300
Message-ID: <CAOMZO5DrJ=T1CZE4bb5bQngrcjDAxMWck-ru25Ew5oeA62L0kA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH] dmaengine: fsl-edma: Add eDMA support for QorIQ
 LS1028A platform
To:     Peng Ma <peng.ma@nxp.com>
Cc:     Vinod <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peng,

On Fri, Oct 18, 2019 at 11:28 AM Peng Ma <peng.ma@nxp.com> wrote:
>
> Hi Fabio,
>
> Thanks for your comments.
> Do you mean I explain "Our platforms" here or in patch?

It would be better to send a v2 with an improved commit log, which
explains what "Our platforms" mean.

Thanks
