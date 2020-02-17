Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17F741610D5
	for <lists+dmaengine@lfdr.de>; Mon, 17 Feb 2020 12:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgBQLP1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Feb 2020 06:15:27 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8092 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbgBQLP1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Feb 2020 06:15:27 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4a75890000>; Mon, 17 Feb 2020 03:14:17 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Feb 2020 03:15:26 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Feb 2020 03:15:26 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Feb
 2020 11:15:24 +0000
Subject: Re: [PATCH v8 18/19] dmaengine: tegra-apb: Remove unused function
 argument
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200209163356.6439-1-digetx@gmail.com>
 <20200209163356.6439-19-digetx@gmail.com>
 <d9a1bd6a-bd26-36ad-7d94-57801a2aa616@nvidia.com>
 <392ccaf4-3cc9-e8af-130c-fa068cc56527@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f9ea6be9-71d6-0119-eade-fe06bbbcbd5b@nvidia.com>
Date:   Mon, 17 Feb 2020 11:15:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <392ccaf4-3cc9-e8af-130c-fa068cc56527@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581938057; bh=IqUsIPOajFVj7mlfzUO0OksNL+6Lww2F+AEKUzn6DIM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=BZsKSUgdgoIKE++6/rKnEpMxrXTWTd/jYmwnO5Uu+YYe6QtKnpSG/3RcakYXB4a+z
         ftHf2tkTYXQ35nU+E5pJ6rJxoecBFoCeFT6KZYcO6oGbqZ0tilNzg1w/3nKXxVfVU0
         YlGTdCJtsGfUTiYZnAbHTzw1/BFywJRi5Cr9qQkI287nis8OmzEct9bvf4ZvPao55i
         ONto1ajBkVlmTHMGjrOt6ulu47PxuVckTX+OGxPOtxLJEEjEw9J8zaaPv1Xmt012OV
         +qLj1vkhSG5uZ37qmufUapiR+VdT6VjhtE9OcKajsVzljCS7PPRD9E/0Al4kBPRezz
         RXCdTulGtLmPA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 14/02/2020 16:54, Dmitry Osipenko wrote:
> 14.02.2020 17:16, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
>> Acked-by: Jon Hunter <jonathanh@nvidia.com>
>>
>> Thanks!
>> Jon
>>
>=20
> Jon, thank you very much!
>=20
> In the patchwork I see that you acked all the patches, but my Gmail
> missed 2 of 4 emails, maybe the missing emails will arrive a day later :)

Yes all should be ACK'ed now. I did receive an email from our mail
server saying that there was an issue and the message was delayed. So
not sure if you ever got it.

Jon

--=20
nvpublic
