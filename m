Return-Path: <dmaengine+bounces-4574-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B72C6A42B51
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2025 19:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A70B3A275C
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2025 18:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257BA198A38;
	Mon, 24 Feb 2025 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Fhr5+N8N"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A292264F88
	for <dmaengine@vger.kernel.org>; Mon, 24 Feb 2025 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421687; cv=none; b=BEyqLVCVR/JdiOJCiJaPI/7X8UAmorowIRD+qVFCX14dzaarze4hSK3ntpMnH/bK3l/1CyTxLmQzSoXTJjIoAgkygSqiOXEzzIi0BzwEus+SC+0al7/TR1tQ2g6OEZA7Qry3C7VhCXeCvgoFlCJCzKxyyc6LV4skpfJU4yODaWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421687; c=relaxed/simple;
	bh=b0+tF/kRXH5wPPFKWXh6xMi5Iu0C787jJ4jbtKrHW7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chfEY172ZPmtRcva6n/dOdszmxo3YA22PyL9oY3GtOAxxPIDiyRQdT52btJM/frQ/qzgyv9B9jDB0eLynZL+dFH+FZHZP+GqBuSzHk2aK0rcZsN97OKX01tWIeqenJqShPYq4HJ1EkOrM5ZaOynYtEwIF0KpyPdGfkhPPkUD7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Fhr5+N8N; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5fd26af3d93so1451082eaf.1
        for <dmaengine@vger.kernel.org>; Mon, 24 Feb 2025 10:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740421684; x=1741026484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=faqWqp1PBWz6bkdg4gIZKK3WyZPaPTN702mjk2GZjXI=;
        b=Fhr5+N8NRr1/rJVU/nnW8oc+l08PQPIWmnSt0Vb2H+k2dS9qn+gAiT16h4A2mViYmQ
         NgYc0o47D67noWQPWC/IeJdHDrgzQom3blKX1BjbxoU/0P7OIizmvBJDTaw5H/6T/AZi
         mAE8AV6xLb8HrRX29k2GLGEPeH3MDm2hgLI5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740421684; x=1741026484;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faqWqp1PBWz6bkdg4gIZKK3WyZPaPTN702mjk2GZjXI=;
        b=UlnltUcdSjv2wOWrBWHkvGv6RkxNdpwPZylhSRoNzGzKNbJ2MWSA7JCuwqA4HxBISb
         MCigd8PAf+4QKGHmARbf2OCbEoDEuKG9d46EmPGNI4Q93lANrLl7+YlyWLt1mSVpP4r7
         4zE2oNvCgO4b2YHy8r+gTP2xhtc7yN4KuGCtsCIefqQ22St8KEhKQ1ZzLhO+HkKEUP4a
         QoC7rxFpCjVRpo1TUySKRR19TKdSk4Y8mRCoO8a6yElyjuFGCuE09vDrZsiAkAzCi7Ms
         u/FqdmXHbMHE+FGoMUx0280kaUSPd8RTgNMmOYnDtKQBq3QhsBrVMY8Nt7bPE9ivw841
         7YTw==
X-Forwarded-Encrypted: i=1; AJvYcCXpBnBBdhA+m9tVcF6M+Mps8ZaxVvQ+uuSOtgC7RFKW0yckIgG7cfBnCUv9Y38wmvnnbubKhXgVLkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI6Y+pupTFG9v42RWFb7DNLWbgOeZ58tzGx76aYrE1F1Cu3VKX
	giEqzPjqHsiq9SG3QgTBgoWqZaL36kmRa1A9KS74AJs8yy4ytRjr0IqKbGcHDA==
X-Gm-Gg: ASbGnctDrnhwKNkZEiXIFW4LhBa31G4zlpFqaUpcwMXfdE4qTFq+98AvdFw+BDB8SfZ
	iF+Yj8w56YITiHqU53GQwenczHFaC0zzKXlJpEi48w0DwAv7O3FFgFFIVldA4mfWsCBOp/uQ8lj
	WO6Q6Aqww++QjRJCxcW9TtUr62h5XTviCQaT/QPAXI4cstHKoBW+njq7ik+BpdKJ255sWjkWQ5C
	highf9MR8jDTvBNUBZ06cuflNWIzlmLgJdgDxHda4+2OoPOe2dEcGxQUSj9LciOqFoqaTE3qDLN
	lb2U10Dr0D7hQC3cqtt//GmSUJhrsI1OiqR1IyhMChUblmEtXoCk9A==
X-Google-Smtp-Source: AGHT+IHVs9kBI7BshAjDAVWgrh+i3GPuho/Oqa5W57T3L5uzRkaZm8JCVHHG2193N2YMEmrqfP7G6g==
X-Received: by 2002:a05:6820:3284:b0:5fc:f02e:a7bf with SMTP id 006d021491bc7-5fd0af6c89amr17901209eaf.3.1740421684520;
        Mon, 24 Feb 2025 10:28:04 -0800 (PST)
Received: from [192.168.99.86] ([216.14.52.203])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fd235ed4fdsm1300638eaf.24.2025.02.24.10.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 10:28:03 -0800 (PST)
Message-ID: <f9ff16f5-9eb2-415b-acaa-706a6ccc8c42@broadcom.com>
Date: Mon, 24 Feb 2025 10:28:02 -0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] dmaengine: bcm2835-dma: fix warning when
 CONFIG_PM=n
To: Stefan Wahren <wahrenst@gmx.net>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Vinod Koul <vkoul@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Peter Robinson <pbrobinson@gmail.com>,
 "Ivan T . Ivanov" <iivanov@suse.de>, linux-arm-kernel@lists.infradead.org,
 bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20250222095028.48818-1-wahrenst@gmx.net>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20250222095028.48818-1-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/22/2025 1:50 AM, Stefan Wahren wrote:
> The old SET_LATE_SYSTEM_SLEEP_PM_OPS macro cause a build warning
> when CONFIG_PM is disabled:
> 
> warning: 'bcm2835_dma_suspend_late' defined but not used [-Wunused-function]
> 
> Change this to the modern replacement.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501071533.yrFb156H-lkp@intel.com/
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


