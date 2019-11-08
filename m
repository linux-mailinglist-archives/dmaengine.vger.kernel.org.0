Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E41EF53C7
	for <lists+dmaengine@lfdr.de>; Fri,  8 Nov 2019 19:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfKHSvl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Nov 2019 13:51:41 -0500
Received: from sender4-pp-o98.zoho.com ([136.143.188.98]:25894 "EHLO
        sender4-pp-o98.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfKHSvl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Nov 2019 13:51:41 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573239085; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=jOPLF+E8aLQ2cGDr2I8xarrs5hWYbyz1Ht0fLRLZ3VmtCFzhEAN20q8MEb5S5M7qIXKSkBEfPk+eoxDoeGD8LzzITJjX3R8D5tYXtiDzXzmCwyaYdVDlOGtl3WPIW9DU2x9pqdDhReU7hjDoT5QuM1bivR5/GXJWJ7TC3SQTb1k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1573239085; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=5cyruCeaBNmdqRxDvTFo4TZqRrFp+acIqpIM6/1ElnQ=; 
        b=MYI24kr7NyrDnB0OtDIq/vg9B0UjSEpB5U7rHGUJa/OlBSTco0vYxeEzWxDGO4PPwPFvwvrGA1LnUsNSaCyHQO2D6gbLR3VsU/9Oa4ux71wYS9UsLAZ6Av0778M8nHaXv8xxNVk7pEdCiZgyzJEtFUHps6FiRVwwCG60ZMcq9jY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=subject:to:references:cc:from:message-id:date:user-agent:mime-version:in-reply-to:content-type; 
  b=V2661Eqp3OM9xq/9mjNHpvwVFe4LW7OQs0M5YtTouTdsn9w4emwV+8tTZCQpAJfIdPqGJ3B0Ty45
    w4Z744ZY29LKVGbPdErtpuylsMSEALNa7TdGUwbqcGY+0+9TqvBY  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1573239085;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        l=680; bh=5cyruCeaBNmdqRxDvTFo4TZqRrFp+acIqpIM6/1ElnQ=;
        b=ZJ6lnqpmAgIUUFrtziBzGZ4zCjvp7qSJ0qCCQwcljGr3je/uig/I07m3GEDypVOB
        z6Q8E+/VYBJrNAtx720ygSKhDnJncdaS2wrV40SWjJQUTKnFKH3TIV57DFI0oq0ZBu4
        U+XP7cbQK6znd5sYYGvrOCDXMAdTP62YodAbNKHY=
Received: from [192.168.10.218] (171.221.112.68 [171.221.112.68]) by mx.zohomail.com
        with SMTPS id 157323908329694.68268716331704; Fri, 8 Nov 2019 10:51:23 -0800 (PST)
Subject: Re: dmaengine: JZ4780: Add support for the X1000 v2
To:     Vinod Koul <vkoul@kernel.org>
References: <1571799903-44561-1-git-send-email-zhouyanjie@zoho.com>
 <1571937670-30828-1-git-send-email-zhouyanjie@zoho.com>
 <20191106171156.GK952516@vkoul-mobl>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, paul@crapouillou.net,
        mark.rutland@arm.com, Zubair.Kakakhel@imgtec.com,
        dan.j.williams@intel.com
From:   Zhou Yanjie <zhouyanjie@zoho.com>
Message-ID: <5DC5B923.2020204@zoho.com>
Date:   Sat, 9 Nov 2019 02:51:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <20191106171156.GK952516@vkoul-mobl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 2019=E5=B9=B411=E6=9C=8807=E6=97=A5 01:11, Vinod Koul wrote:
> On 25-10-19, 01:21, Zhou Yanjie wrote:
>> v1->v2:remove flag JZ_SOC_DATA_ALLOW_LEGACY_DT.
>>
> Hmm this cover letter is devoid of any details for the series. One would
> expect a description of the series attempting to address.
>
> Neverthless I have applied, but in future please take care to write a
> *decent* cover letter and also document changes as you done in the only
> line.
>
> Also auto generate the letter using --cover-letter option, it shows up
> nice diff stat which helps while applying
>
> Thanks
>

Thanks, I will pay more attention in the future.

Best regards!


