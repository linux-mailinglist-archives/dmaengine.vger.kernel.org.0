Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AB1232448
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jul 2020 20:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgG2SBK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jul 2020 14:01:10 -0400
Received: from mout.web.de ([212.227.15.14]:46365 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgG2SBK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 29 Jul 2020 14:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1596045654;
        bh=9PUsmeJ/Eu2U/dEfEIqHbVv+xuvUkaqLv2+jYfnT/UU=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=B2dyOx1yqvPo6hWQExWbPQ4KMDlUC4qGYCDQrifrAg+iMfabZxE5fzzccANXrH29O
         K0rwz3on/p3eEq4xePqKUKpTIgf4FcRadRmr+FEK53GkVDJsnYW5BcxRYSi2feEhKt
         snc5TC/4CNTCkdMN0odDKdgTx7u7ho3NOiG0AGe0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.175.129]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJnvp-1kKQVL30tF-00K85N; Wed, 29
 Jul 2020 20:00:54 +0200
To:     Yu Kuai <yukuai3@huawei.com>, dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Anup Patel <anup.patel@broadcom.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ray Jui <ray.jui@broadcom.com>, Vinod Koul <vkoul@kernel.org>,
        Yi Zhang <yi.zhang@huawei.com>
Subject: Re: [PATCH V2] dmaengine: bcm-sba-raid: add missing put_device() call
 in sba_probe()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0510b837-cb5f-c8d0-8cd9-1c7c871a4ea0@web.de>
Date:   Wed, 29 Jul 2020 20:00:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pCl43vM7BT8F70NnD2x7YGLM7GW0DuYAzERvZ77H7pfwiq3Zt4J
 pqq2uq9c2xy1iqSHWRDY44AMkZYhJw0Xj8VDyBMDp73YEqx0nLrnqJyWw3NQ1FV5ue9NlW8
 AINQKvvmXR7hxxIJWbd+xfRCO3s4Gk1SVPiK+q7e2IuTx/zHsGHqBddFTAdI8jeQyCZZ7SI
 pROQ9g6aGOpID4DwXzUiw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ygTbAk2qY+s=:7tWJm7IO7CGOJ4SPn6m0YD
 I1bt5lG4fZlIyIuBwCDkpJJGNvCC0cw6DD/uQ6JkmEg/o0IY7ypVtkzsop8SakhEJD3b04xtQ
 Oc/e41OH0wuourBPjdKdKDLDkCBaWEgE1F3F5w0ssxe7HY8eVrw/fk0wn0mncsUWLtbga9DYW
 F/lfodxIS/Sro1GG547T6uufK6fzeO453k704cFl5yfkSPlNUzbGmpmA2UauQScFh3tCEKAcO
 WJHMtUmbJPRjLeMuoe8tY0g1vFD7wqBHzVBXzUDaHd09GFyckf7tnc4OkCaRVsuix7bsegQ1/
 0AzFGDFXaopdco0r0eGdhUDR8LXbC+ptaJIhyacJo8D9qL/bdErHXz53JokDTRMBZnXEBkLOz
 UkJ9d+ACSe3W4B3eXCt51Pfm3l1N4caostnm+G472cwYJ/h8X5+GIAu1feZBUoPMR9abvUbJD
 CibOijbMRgBWsGhbiurD3C7KOhBaSJIGgsipkjUMqEWhHYnFkq0wAQXI/y0GDxNvaooowIv5l
 UcQeZw6EvrVbingD5N7iegGb7Ozh9gnMCLbgwo2FQ8PQJwoL7PtTbM/a5Ikd6ebe1fFfLnsRD
 OkxPCmuq/fqRoHfvApwogtEocXx7+6vEJ2+Xm4SorXKy1zsxg0oj3Unq0RiaFLDAf+dvIrAbX
 cWZfwd3J0Lra/9fm3SviyB3L4X5pyx24809UiukqPU+yKkVYnd+xvn8gGhZA4PpfdK0yV5nTc
 v4cOrnSrQxXrSz5kbrMSXit7UCI9bxQIcUMpe3LTFkwkizfghVGZqQXgoeXiUtwkfw8ph+0BI
 al+Qcpm2cLvO7+3gW6ZxvQPXN6xwJoBPbnXTTDL7eP23fvasyVy57u+ii0c9r5T1fj6s2/cn/
 wCG8zCUpO0Q9dp7kiH4SOZpv9hCoxld06leGQWU9O/eGO6IRyteqT+inpqhDvtUufTrZxuKRo
 6nt8n1pGxJg2DvZ1ZWZ1kZB1hm+HNqOr+6FW9eSgR7mO9eErGBz7HoTvYZCZwHZu3bSAFEAf3
 5PMLL6CLjlmtgPAdlWZEibEMcMIucd3DbsS4BkCObAVPxHd+YmkC5ZqJ3mGgYZQerJtxJg8Dm
 taWEWAf+lCyu+8HMDNH0nIP5XD4urxLNga+4z9Xf5WY9BMq21c0Syzl4a18aZv8oj0bItvsib
 GbkpiqMVDTqYLSf1a5CyjzPdhuqeidWyg+pw3Cghh6KN0NBMyTD6fSCMKPJtZ//0AWOxOfuYz
 286SOPMh0ufpJg0+FbTJ9UUydd+feFC5Vuo9/lQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> if of_find_device_by_node() succeed, sba_probe() doesn't have a
> corresponding put_device(). =E2=80=A6

Wording adjustment:
  If a of_find_device_by_node() call succeeded, sba_probe() did not
  contain a corresponding put_device() call. =E2=80=A6

Regards,
Markus
