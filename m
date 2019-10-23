Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A95DAE12AF
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 09:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389663AbfJWHFy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Oct 2019 03:05:54 -0400
Received: from sender4-pp-o94.zoho.com ([136.143.188.94]:25484 "EHLO
        sender4-pp-o94.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731524AbfJWHFx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Oct 2019 03:05:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571814345; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=jr7mWKEKLyiwfuKNe153uS0njAj9MTrbFHzTeWpXZUEUJRAknqW3EPEJlx/h8bIiSCdnd015aji3qZH9/YxvhTsK3kUkTPcQ9RWK+aWuscnX4Lm0Q7t+Ar9J4by6QI1K8kuxSeFnFF65x1n6XbOPwXMIaUdL2QDhxdm3CngQzPk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1571814345; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=WPsbhAfF3C26wxU12FTMldjsNOHj3+246cITfOLeTA8=; 
        b=RGkZKe3UfI3ihSwxcKLHbyGH4UFd88zzFl0YiWVrhLvi+HYnqxZAgKNK6u2nRxuefNjLyri9yxe95TRfx8pJ5Vr6vs1ur2wTK2/M/24V+34oGOu1IQc1SygRmIKtmgKSArQ7bGdjTP6+TLo0bjwdZX/s49+0CTqcVTBXpUUeA3s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=subject:to:references:cc:from:message-id:date:user-agent:mime-version:in-reply-to:content-type; 
  b=HNvJON1v3X9nvG9gzrH5476wN1ykojZz1m1MEb9vzMNlkrj+5l2U0cCuvwyrd0+NWMVSVDFluU7v
    Bs6QbhgHG9w8ODsFws9eUd+aGfnDC0l/Q8XTte76QRE4h9PeeunD  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571814345;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        l=411; bh=WPsbhAfF3C26wxU12FTMldjsNOHj3+246cITfOLeTA8=;
        b=aAe58B4m49uzhA+cNEx66K1JkI4BJpmSB2UWUQUdqBe3L5nRgA0NZHca9awulPKz
        i3Og2l3cNDDGjQaJBoSsW8KKAT1ZPLYp8gPggjCTKuQnA6rVkIp6RJuXmymzpFKCKeA
        kEjOTMdFaGH9dgFg1CNTdHTiuPizcM8p//6bAt+k=
Received: from [192.168.88.140] (125.71.5.36 [125.71.5.36]) by mx.zohomail.com
        with SMTPS id 1571814345090395.0371569746694; Wed, 23 Oct 2019 00:05:45 -0700 (PDT)
Subject: Re: DMA: JZ4780: Add DMA driver for X1000.
To:     Vinod Koul <vkoul@kernel.org>
References: <1571799903-44561-1-git-send-email-zhouyanjie@zoho.com>
 <20191023051501.GQ2654@vkoul-mobl>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, paul@crapouillou.net,
        mark.rutland@arm.com, Zubair.Kakakhel@imgtec.com,
        dan.j.williams@intel.com
From:   Zhou Yanjie <zhouyanjie@zoho.com>
Message-ID: <5DAFFBBC.2080207@zoho.com>
Date:   Wed, 23 Oct 2019 15:05:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <20191023051501.GQ2654@vkoul-mobl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 2019=E5=B9=B410=E6=9C=8823=E6=97=A5 13:15, Vinod Koul wrote:
> On 23-10-19, 11:05, Zhou Yanjie wrote:
>> 1.Add the DMA bindings for the X1000 SoC from Ingenic.
>> 2.Add support for probing the dma-jz4780 driver on the
>>    X1000 SoC from Ingenic.
> The subsystem in dmaengine and not dma
>
> Please resend with correct tags!
>
> Thanks

I already resend this patches.

Best regards!



